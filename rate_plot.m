clc; clear; close all;
EbNodB = 2.5:-0.5:0;
BER1 = [    3.9530931e-05   1.7440116e-04   1.5765865e-03   6.8109468e-03   2.4504526e-02   6.3107643e-02 ];
BER2 = [   0.0000000e+00   1.9998000e-04   1.5975147e-03   7.2202082e-03   2.5813698e-02   6.3968022e-02];
BER3 = [   8.6968047e-04   5.5157275e-03   1.8639996e-02   5.3496976e-02   1.0712185e-01   1.8511172e-01];
BER4 = [   1.3277742e-03   5.6901287e-03   2.1549008e-02   5.0853054e-02   1.0701023e-01   1.8319563e-01];
BER5 = [   1.1626744e-03   6.4644698e-03   1.9272491e-02   5.5006127e-02   1.1108657e-01   1.9507584e-01];
BER6 = [   9.9059861e-04   6.1342703e-03   2.0707232e-02   5.3115619e-02   1.1383745e-01   1.8761612e-01];
%BER7 = [0.0000000e+00   8.1991801e-05   4.6595340e-04   2.9897010e-03   1.5992401e-02];

figure(1);
h=semilogy(EbNodB,BER1,'-o',EbNodB,BER2,'--+',EbNodB,BER3,'-*',EbNodB,BER4,'--.',EbNodB,BER5,'-^',EbNodB,BER6,'--v'); hold on; grid on; xlabel('EbNo dB');ylabel('BER'); title('Downlink A = 43; nL=8; QPSK');
axis([min(EbNodB) max(EbNodB) 1e-4 1]); legend('Toolbox Puncturing E=236; R=0.272; N=256;','SCL Puncturing E=236; R=0.272; N=256;','Toolbox Shortening E=120; R=0.533; N=128;','SCL Shortening E=120; R=0.533; N=128;', ... 
    'Toolbox Repetition E=132; R=0.485; N=128;', 'SCL Repetition E=132; R=0.485; N=128;'); 
set(h,'linewidth',1);

