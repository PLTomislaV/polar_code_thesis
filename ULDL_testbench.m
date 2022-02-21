clc; clear; close all;

max_blocks = 10000;
EbNodB = 2.5:-0.5:1;
max_bit_errors = 10000000;


E = 184;
A = 50;

nL=8;
BER1 = zeros(1,length(EbNodB));
BER2 = zeros(1,length(EbNodB));
BER3 = zeros(1,length(EbNodB));
BER4 = zeros(1,length(EbNodB));
BER5 = zeros(1,length(EbNodB));
BER6 = zeros(1,length(EbNodB));
BER7 = zeros(1,length(EbNodB));

parfor kk = 1:length(EbNodB)
    
    tic
    [BER1(kk), BLER1(kk),SNR1(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','Toolbox`','DL','QPSK');
    disp('5G');
    toc
    
      tic
    [BER2(kk), BLER2(kk),SNR2(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','Toolbox`','UL','QPSK');
    disp('5G');
    toc
    
    tic
    [BER3(kk), BLER3(kk),SNR3(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','SCL','DL','QPSK');
    disp('NPTEL LIST');
    toc
    
     tic
    [BER4(kk), BLER4(kk),SNR4(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','SCL','UL','QPSK');
    disp('NPTEL LIST');
    toc

    disp(EbNodB(kk)); 
end

figure(1);
semilogy(EbNodB,BER1,'-o',EbNodB,BER2,'--+',EbNodB,BER3,'-.^',EbNodB,BER4,'-*'); hold on; grid on; xlabel('EbNo dB');ylabel('BER'); title('E = 184; A = 50; nL=8; QPSK');
axis([min(EbNodB) max(EbNodB) 1e-5 1]); legend('Toolbox DL','Toolbox UL','SCL DL','SCL UL'); 

figure(2);
semilogy(EbNodB,BLER1,'-o',EbNodB,BLER2,'--+',EbNodB,BLER3,'-.^',EbNodB,BLER4,'-*'); hold on; grid on; xlabel('EbNo dB');ylabel('BLER'); title('E = 184; A = 50; nL=8; QPSK');
axis([min(EbNodB) max(EbNodB) 1e-5 1]); legend('Toolbox DL','Toolbox UL','SCL DL','SCL UL'); 
