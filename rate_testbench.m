clc; clear; close all;

max_blocks = 10000;
EbNodB = 2.5:-0.5:0;
max_bit_errors = 100000;


A = 43;

%puncturing 
E = 236;
% R=0,2717 K= 64; N=256; %DL CRC 21
%puncturing 







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
        'Toolbox','SCL','DL','QPSK');
    disp('NPTEL LIST');
    toc
   disp(EbNodB(kk)); 
end




%shortening
E = 120;
%N=128; K= 64; R=0,5333
%shortening
parfor kk = 1:length(EbNodB)
    
    tic
    [BER3(kk), BLER3(kk),SNR3(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','Toolbox`','DL','QPSK');
    disp('5G');
    toc

    tic
    [BER4(kk), BLER4(kk),SNR4(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','SCL','DL','QPSK');
    disp('NPTEL LIST');
    toc

    disp(EbNodB(kk)); 
end




%repetition
E = 132;
%N=128;
%repetition

parfor kk = 1:length(EbNodB)
    
    tic
    [BER5(kk), BLER5(kk),SNR5(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','Toolbox`','DL','QPSK');
    disp('5G');
    toc

    tic
    [BER6(kk), BLER6(kk),SNR6(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'Toolbox','SCL','DL','QPSK');
    disp('NPTEL LIST');
    toc

    disp(EbNodB(kk)); 
end



%plot
figure(1);
semilogy(EbNodB,BER1,'-o',EbNodB,BER2,'--+',EbNodB,BER3,'-*',EbNodB,BER4,'--.',EbNodB,BER5,'-^',EbNodB,BER6,'--v'); hold on; grid on; xlabel('EbNo dB');ylabel('BER'); title('Downlink A = 43; nL=8; QPSK');
axis([min(EbNodB) max(EbNodB) 1e-5 1]); legend('Toolbox Puncturing E=236; R=0.272; N=256;','SCL Puncturing E=236; R=0.272; N=256;','Toolbox Shortening E=120; R=0.533; N=128;','SCL Shortening E=120; R=0.533; N=128;', ... 
    'Toolbox Repetition E=132; R=0.485; N=128;', 'SCL Repetition E=132; R=0.485; N=128;'); 

figure(2);
semilogy(EbNodB,BLER1,'-o',EbNodB,BLER2,'--+',EbNodB,BLER3,'-*',EbNodB,BLER4,'--.',EbNodB,BLER5,'-^',EbNodB,BLER6,'--v'); hold on; grid on; xlabel('EbNo dB');ylabel('BLER'); title('Downlink A = 43; nL=8; QPSK');
axis([min(EbNodB) max(EbNodB) 1e-5 1]); legend('Toolbox Puncturing E=236; R=0.272; N=256;','SCL Puncturing E=236; R=0.272; N=256;','Toolbox Shortening E=120; R=0.533; N=128;','SCL Shortening E=120; R=0.533; N=128;', ... 
    'Toolbox Repetition E=132; R=0.485; N=128;', 'SCL Repetition E=132; R=0.485; N=128;'); 