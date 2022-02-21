clc; clear; close all;

max_blocks = 100000;
EbNodB = 3.5:-0.5:2.5;
max_bit_errors = 1000000000;


A = 43;

%puncturing 

%E = 236;%rate match into this length
% R=0,2717 K= 64; N=256;
%puncturing 


%shortening
%E = 120;
%N=128; K= 64; R=0,5333
%shortening


%repetition
%E = 132;
%N=128;
%repetition






nL=4;
for kk = 1:length(EbNodB)
    
    tic
    [BER3(kk), BLER3(kk),SNR3(kk)] = transmit_chain(EbNodB(kk),A,E,max_bit_errors,max_blocks,nL, ...
        'polar_encode','SCL`','DL','QPSK');
    disp('5G');
    toc
end
figure(1);
semilogy(EbNodB,BER3,BLER3);