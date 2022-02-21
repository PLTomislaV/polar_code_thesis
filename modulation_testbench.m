clc; clear; close all;

%max_blocks = 10000;
EbNodB = 4:-0.5:1;
%max_bit_errors = 1000000;
max_blocks = 2000;
max_bit_errors = 20000;
E = 180;
A = 50;

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
        'Toolbox','SCL`','DL','BPSK');
    disp('5G');
    toc
    
      tic
    [BER2(kk), BLER2(kk),SNR2(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','SCL`','DL','QPSK');
    disp('5G');
    toc
    
    tic
    [BER3(kk), BLER3(kk),SNR3(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','SCL','DL','16QAM');
    disp('NPTEL LIST');
    toc
    
     tic
    [BER4(kk), BLER4(kk),SNR4(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','SCL','DL','64QAM');
    disp('NPTEL LIST');
    toc

    disp(EbNodB(kk)); 
end

figure(1);
h=semilogy(EbNodB,BER1,'-o',EbNodB,BER2,'--+',EbNodB,BER3,'-.^',EbNodB,BER4,'-*'); hold on; grid on; xlabel('EbNo dB');ylabel('BER'); title('Downlink SCL E = 180; A = 50; nL=8;');
axis([min(EbNodB) max(EbNodB) 1e-4 1]); legend('BPSK','QPSK','16QAM','64QAM'); 
set(h,'linewidth',1);

figure(2);
semilogy(EbNodB,BLER1,'-o',EbNodB,BLER2,'--+',EbNodB,BLER3,'-.^',EbNodB,BLER4,'-*'); hold on; grid on; xlabel('EbNo dB');ylabel('BLER'); title('Downlink SCL E = 180; A = 50; nL=8;');
axis([min(EbNodB) max(EbNodB) 1e-5 1]); legend('BPSK','QPSK','16QAM','64QAM'); 