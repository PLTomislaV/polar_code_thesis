clc; clear; close all;
EbNodB = 3:-0.5:1;
BER1 = [   3.1868626e-04   1.1029044e-03   7.1891872e-03   2.9178539e-02   6.9711058e-02 ];
BER2 = [   0.0000000e+00   0.0000000e+00   1.4059688e-04   7.1841101e-03   7.0583454e-02 ];





figure(1);
h=semilogy(EbNodB,BER1,'-o',EbNodB,BER2,'-.^'); hold on; grid on; xlabel('EbNo dB');ylabel('BER'); title('Uplink SCL nL=8; QPSK');
axis([min(EbNodB) max(EbNodB) 1e-4 1e-1]); legend('A=64; E=128;','A=512; E=1024;'); 
set(h,'linewidth',1);

