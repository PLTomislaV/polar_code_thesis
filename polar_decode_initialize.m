function out = polar_decode_initialize(in,K,E,nL,nMax,iIL,crcLen,decoder_type)
    % nr5g.internal.polar.getN
    cl2e = ceil(log2(E));
    if (E <= (9/8) * 2^(cl2e-1)) && (K/E < 9/16)
        n1 = cl2e-1;
    else
        n1 = cl2e;
    end

    rmin = 1/8;
    n2 = ceil(log2(K/rmin));

    nMin = 5;
    n = max(min([n1 n2 nMax]),nMin);
    N = 2^n;
    
    % nr5g.internal.polar.construct
            % for CA-Polar
        nPC = 0;
        nPCwm = 0;


    % Get sequence for N ascending ordered,
    s10 = nr5g.internal.polar.sequence;
    idx = (s10 < N);
    qSeq = s10(idx);                         
    

    jn = nr5g.internal.polar.subblockInterleaveMap(N);  
    qFtmp = [];
    if E < N
        if K/E <= 7/16  % puncturing
            for i = 0:(N-E-1)
                qFtmp = [qFtmp; jn(i+1)];  
            end
            if E >= 3*N/4
                uLim = ceil(3*N/4-E/2);
                qFtmp = [qFtmp; (0:uLim-1).'];
            else
                uLim = ceil(9*N/16-E/4);
                qFtmp = [qFtmp; (0:uLim-1).'];
            end
            qFtmp = unique(qFtmp);
        else            % shortening
            for i = E:N-1
                qFtmp = [qFtmp; jn(i+1)];  
            end
        end
    end
    

    qI = zeros(K+nPC,1);
    j = 0;
    for i = 1:N
        ind = qSeq(N-i+1);      
        if any(ind==qFtmp)
            continue;
        end
        j = j+1;
        qI(j) = ind;
        if j==(K+nPC)
            break;
        end
    end


    qF = setdiff(qSeq,qI);    

    F = zeros(N,1);
    F(qF+1) = ones(length(qF),1);


    
    %POLAR DECODE
    padCRC = false;
    rnti = 0;
    if strcmpi(decoder_type,'SC')
        outkpc = polar_decode_SC(in,F,iIL);
    else 
        outkpc = polar_decode_SCL(in,F,nL,iIL,crcLen,padCRC,rnti);
    end
    
    
    
        out = outkpc;
 
end
 