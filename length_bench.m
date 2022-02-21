

clc; clear; close all;

max_blocks = 10000;
EbNodB = 3:-0.5:1;
max_bit_errors = 100000;


E = 184;
A = 50;
s=rng(100);
nL=4;
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
    rng(s); 
    tic
    [BER2(kk), BLER2(kk),SNR2(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','SCL','DL','QPSK');
    disp('NPTEL LIST');
    toc
    rng(s); 
    tic
    [BER3(kk), BLER3(kk),SNR3(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','SC','DL','QPSK');
    disp('NPTEL SC');
    toc
    rng(s); 
    disp(EbNodB(kk)); 
end


nL=8;
parfor kk = 1:length(EbNodB)
    
    tic
    [BER4(kk), BLER4(kk),SNR4(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','Toolbox`','DL','QPSK');
    disp('5G');
    toc
    rng(s); 
    tic
    [BER5(kk), BLER5(kk),SNR5(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','SCL','DL','QPSK');
    disp('NPTEL LIST');
    toc
    rng(s); 
    disp(EbNodB(kk)); 
end


nL=16;
parfor kk = 1:length(EbNodB)
    
    tic
    [BER6(kk), BLER6(kk),SNR6(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','Toolbox`','DL','QPSK');
    disp('5G');
    toc
    rng(s); 
    tic
    [BER7(kk), BLER7(kk),SNR7(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','SCL','DL','QPSK');
    disp('NPTEL LIST');
    toc
    rng(s); 
    disp(EbNodB(kk)); 
end

figure(1);
h = semilogy(EbNodB,BER1,'-o',EbNodB,BER2,'--+',EbNodB,BER3,'.-.',EbNodB,BER4,'-*',EbNodB,BER5,'--.',EbNodB,BER6,'-^',EbNodB,BER7,'--v'); hold on; grid on; xlabel('EbNo dB');ylabel('BER'); title('Downlink E = 184; A = 50; QPSK');
axis([min(EbNodB) max(EbNodB) 1e-4 1e-1]); legend('Toolbox nL=4','SCL nL=4','SC','Toolbox nL=8','SCL nL=8','Toolbox nL=16','SCL nL=16'); 
set(h,'linewidth',1);

figure(2);
semilogy(EbNodB,BLER1,'-o',EbNodB,BLER2,'--+',EbNodB,BLER3,'.-.',EbNodB,BLER4,'-*',EbNodB,BLER5,'--.',EbNodB,BLER6,'-^',EbNodB,BLER7,'--v'); hold on; grid on; xlabel('EbNo dB');ylabel('BLER'); title('Downlink E = 184; A = 50;');
axis([min(EbNodB) max(EbNodB) 1e-6 1]); legend('Toolbox nL=4','SCL nL=4','SC','Toolbox nL=8','SCL nL=8','Toolbox nL=16','SCL nL=16'); 
