clc; clear; close all;
EbNodB = 2.5:-0.5:1;
BER1 = [  1.8798120e-04   1.3498650e-03   7.6472353e-03   2.5403460e-02];
BER2 = [     1.7198280e-04   7.3992601e-04   3.2636736e-03   1.2734727e-02];
BER3 = [    2.0797920e-04   1.4838516e-03   8.4611539e-03   2.6899310e-02];
BER4 = [    3.7996200e-05   6.8193181e-04   3.6616338e-03   1.2084792e-02];
BLER1 = [  9.9990001e-04   5.3994601e-03   2.6897310e-02   8.4591541e-02];
BLER2 = [     5.9994001e-04   3.1996800e-03   1.1898810e-02   4.1895810e-02];
BLER3 = [   1.3998600e-03   5.6994301e-03   2.8997100e-02   8.7191281e-02];
BLER4 = [     2.9997000e-04   2.0997900e-03   1.3298670e-02   4.0895910e-02];


figure(1);
h=semilogy(EbNodB,BER1,'-o',EbNodB,BER2,'--+',EbNodB,BER3,'-.^',EbNodB,BER4,'-*'); hold on; grid on; xlabel('EbNo dB');ylabel('BER'); title('E = 184; A = 50; nL=8; QPSK');
axis([min(EbNodB) max(EbNodB) 1e-4 1e-1]); legend('Toolbox DL','Toolbox UL','SCL DL','SCL UL'); 
set(h,'linewidth',1);

figure(2);
g=semilogy(EbNodB,BLER1,'-o',EbNodB,BLER2,'--+',EbNodB,BLER3,'-.^',EbNodB,BLER4,'-*'); hold on; grid on; xlabel('EbNo dB');ylabel('BLER'); title('E = 184; A = 50; nL=8; QPSK');
axis([min(EbNodB) max(EbNodB) 1e-4 1e-1]); legend('Toolbox DL','Toolbox UL','SCL DL','SCL UL'); 
set(g,'linewidth',1);
