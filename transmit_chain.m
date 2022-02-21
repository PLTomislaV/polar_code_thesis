function [BER,BLER,snrdB] = transmit_chain(EbNo,A,E,max_bit_errors,max_blocks,nL,encoder_type,decoder_type,linkDir,modulation_type)

%'pi/2-BPSK' | 'BPSK' | 'QPSK' | '16QAM' | '64QAM' | '256QAM'Ds
if strcmpi(modulation_type,'pi/2-BPSK')
    bps = 1;
elseif strcmpi(modulation_type,'BPSK')
    bps = 1;
elseif strcmpi(modulation_type,'QPSK')
    bps = 2;
elseif strcmpi(modulation_type,'16QAM')
    bps = 4;
elseif strcmpi(modulation_type,'64QAM')
    bps = 6;
elseif strcmpi(modulation_type,'256QAM')
    bps = 8;
end
    

if strcmpi(linkDir,'DL')
    % Downlink scenario (K >= 36, including CRC bits)
    crcLen = 24;      % Number of CRC bits for DL, 
    poly = '24C';     % CRC polynomial
    %nPC = 0;          % Number of parity check bits,
    nMax = 9;         % Maximum value of n(depth), for N=2^n, 
    iIL = true;       % Interleave input, 
    iBIL = false;     % Interleave coded bits,
else
% Uplink scenario (K > 30, including CRC bits) (for 18 <= K <= 25
    crcLen = 11;
    poly = '11';
    nMax = 10;
    iIL = false;
    iBIL = true;
end


K = A + crcLen;
R = K/E;
EsNo = EbNo + 10*log10(bps); 
snrdB = EsNo + 10*log10(R);
noiseVar = 1./(10.^(snrdB/10)); 





% Channel SETUP
chan = comm.AWGNChannel('NoiseMethod','Variance','Variance',noiseVar);



bit_errors = 0; Loops = 0; block_errors = 0;
while bit_errors <= max_bit_errors 
    if Loops > max_blocks
        break
    end


% Generate a random message
    msg = randi([0 1],A,1);

    % Attach CRC
    msgcrc = nrCRCEncode(msg,poly);

    % Polar encode
    if strcmpi(encoder_type,'polar_encode')
        encOut = polar_encode_initialize(msgcrc,E,nMax,iIL);
    else
        encOut = nrPolarEncode(msgcrc,E,nMax,iIL);
    end
    N = length(encOut);

    % Rate match
    modIn = nrRateMatchPolar(encOut,K,E,iBIL);

    % Modulate
    modOut = nrSymbolModulate(modIn,modulation_type);

    % Add White Gaussian noise
    rSig = chan(modOut);
    
    % SOFT demodulate --- LLR 
    rxLLR = nrSymbolDemodulate(rSig,modulation_type,noiseVar);

    % Rate recover
    decIn = nrRateRecoverPolar(rxLLR,K,N,iBIL);

    % Polar decode
    if strcmpi(decoder_type,'SC')
        decBits = polar_decode_initialize(decIn,K,E,nL,nMax,iIL,crcLen,decoder_type);
    elseif strcmpi(decoder_type,'SCL')
        decBits = polar_decode_initialize(decIn,K,E,nL,nMax,iIL,crcLen,decoder_type);
    else
        decBits = nrPolarDecode(decIn,K,E,nL,nMax,iIL,crcLen);
    end
    

block_errors = block_errors + any(decBits(1:A)~=msg);

Loops = Loops +1;

bit_errors = bit_errors + sum(double(decBits(1:A)) ~= msg);
end

BER = bit_errors/(Loops*A);
BLER = (block_errors/Loops);

end

