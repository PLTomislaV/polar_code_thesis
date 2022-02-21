


clc; clear; close all;

max_blocks = 100000;
EbNodB = 3.5:-0.5:2.5;
max_bit_errors = 1000000000;


   
E = 184;%rate match into this length
A = 19; %randomly generated message bits


nL=8; % LIST LENGTH

BER1 = zeros(1,length(EbNodB));
BER2 = zeros(1,length(EbNodB));
BER3 = zeros(1,length(EbNodB));
BLER1 = zeros(1,length(EbNodB));
BLER2 = zeros(1,length(EbNodB));
BLER3 = zeros(1,length(EbNodB));
SNR2 = zeros(1,length(EbNodB));

%'pi/2-BPSK' | 'BPSK' | 'QPSK' | '16QAM' | '64QAM' | '256QAM'
parfor kk = 1:length(EbNodB)
    
    tic
    [BER3(kk), BLER3(kk),SNR3(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        '5G','SCL`','DL','QPSK');
    disp('5G');
    toc
    
    
    tic
    [BER1(kk), BLER1(kk),SNR1(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'polar_encode','SCL','DL','QPSK');
    disp('NPTEL LIST');
    toc
    
    

    
    tic
    [BER2(kk), BLER2(kk),SNR2(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'polar_encode','SC','DL','QPSK');
    disp('NPTEL SC');
    toc
    

    
    disp(EbNodB(kk)); 
end
A = 43;
E = 128;
%shortening


parfor kk = 1:length(EbNodB)

        
    
        tic
    [BER4(kk), BLER4(kk),SNR4(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'polar_encode','5G','DL','QPSK');
    disp('5G2');
    toc
    
    
    tic
    [BER5(kk), BLER5(kk),SNR5(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'polar_encode','SCL','DL','QPSK');
    disp('NPTEL LIST2');
    toc
    
    
    
end

E = 132;
%repetition

parfor kk = 1:length(EbNodB)

        
    
        tic
    [BER6(kk), BLER6(kk),SNR6(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'polar_encode','5G','DL','QPSK');
    disp('5G3');
    toc
    
    
    tic
    [BER7(kk), BLER7(kk),SNR7(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'polar_encode','SCL','DL','QPSK');
    disp('NPTEL LIST3');
    toc
    
    
    
end



%semilogy(EbNodB,BER3);
figure(1);
semilogy(EbNodB,BER3,EbNodB,BER2,EbNodB,BER1,EbNodB,BER4,EbNodB,BER5,EbNodB,BER6,EbNodB,BER7); hold on; grid on; xlabel('EbNo dB');ylabel('propability BER'); 
axis([min(EbNodB) max(EbNodB) 1e-6 1]); legend('5G','NPTEL SC','SCL','5G2','SCL2','5G3','SCL3');

figure(2);
semilogy(EbNodB,BLER3,EbNodB,BLER2,EbNodB,BLER1,EbNodB,BLER4,EbNodB,BLER5,EbNodB,BLER6,EbNodB,BLER7); hold on; grid on; xlabel('EbNo dB');ylabel('propability BLER'); 
axis([min(EbNodB) max(EbNodB) 1e-6 1]); legend('5G','NPTEL SC','SCL','5G2','SCL2','5G3','SCL3');


figure(3);
semilogy(SNR3,BER3,SNR2,BER2,SNR1,BER1,SNR4,BER4,SNR5,BER5,SNR6,BER6,SNR7,BER7); hold on; grid on; xlabel('SNR dB');ylabel('probability BER'); 
legend('5G','NPTEL SC','SCL','5G2','SCL2','5G3','SCL3');


figure(4);
semilogy(SNR3,BLER3,SNR2,BLER2,SNR1,BLER1,SNR4,BLER4,SNR5,BLER5,SNR6,BLER6,SNR7,BLER7); hold on; grid on; xlabel('SNR dB');ylabel('probability BLER'); 
legend('5G','NPTEL SC','SCL','5G2','SCL2','5G3','SCL3');

