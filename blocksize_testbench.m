clc; clear; close all;

%max_blocks = 10000;
EbNodB = 3.5:-0.5:1;
%max_bit_errors = 1000000;
max_blocks = 5000;
max_bit_errors = 50000;
E = 128;
A = 64;

nL=8;
BER1 = zeros(1,length(EbNodB));
BER2 = zeros(1,length(EbNodB));
BER3 = zeros(1,length(EbNodB));
BER4 = zeros(1,length(EbNodB));
BER5 = zeros(1,length(EbNodB));
BER6 = zeros(1,length(EbNodB));
BER7 = zeros(1,length(EbNodB));
%'pi/2-BPSK' | 'BPSK' | 'QPSK' | '16QAM' | '64QAM' | '256QAM'Ds
parfor kk = 1:length(EbNodB)
    
    tic
    [BER1(kk), BLER1(kk),SNR1(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','SCL`','UL','QPSK');
    toc
    

    disp(EbNodB(kk)); 
end



E = 1024;
A = 512;
parfor kk = 1:length(EbNodB)
    
    tic
    [BER2(kk), BLER2(kk),SNR2(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','SCL`','UL','QPSK');
    toc
    

    disp(EbNodB(kk)); 
end


figure(1);
semilogy(EbNodB,BER1,'-o',EbNodB,BER2,'-.^'); hold on; grid on; xlabel('EbNo dB');ylabel('BER'); title('Uplink SCL nL=8; QPSK');
axis([min(EbNodB) max(EbNodB) 1e-5 1]); legend('A=64; E=128;','A=512; E=1024;'); 

figure(2);
semilogy(EbNodB,BLER1,'-o',EbNodB,BLER2,'-.^'); hold on; grid on; xlabel('EbNo dB');ylabel('BLER'); title('Uplink SCL nL=8; QPSK');
axis([min(EbNodB) max(EbNodB) 1e-5 1]); legend('A=64; E=128;','A=512; E=1024;'); 