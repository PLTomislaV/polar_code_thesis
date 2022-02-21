clc; clear; close all;
EbNodB = 3:-0.5:1;
BER1 = [ 1.5198480e-04   8.5591441e-04   3.6596340e-03   1.4840516e-02   4.0341966e-02 ];
BER2 = [ 1.0598940e-04   7.1392861e-04   3.4456554e-03   1.5414459e-02   4.2105789e-02 ];
BER3 = [ 4.4975502e-03   1.2690731e-02   3.1506849e-02   6.8705129e-02   1.1707829e-01 ];
BER4 = [2.7997200e-05   1.5998400e-04   1.9618038e-03   7.1372863e-03   2.5029497e-02];
BER5 = [3.7996200e-05   3.3996600e-04   1.5418458e-03   8.2671733e-03   2.4913509e-02];
BER6 = [0.0000000e+00   9.5990401e-05   7.3592641e-04   4.1475852e-03   1.6896310e-02];
BER7 = [0.0000000e+00   8.1991801e-05   4.6595340e-04   2.9897010e-03   1.5992401e-02];


BLER1 = [ 6.9993001e-04   3.9996000e-03   1.6198380e-02   5.7894211e-02   1.4378562e-01];
BLER2 = [ 5.9994001e-04   3.3996600e-03   1.5198480e-02   5.7394261e-02   1.4848515e-01];
BLER3 = [  2.4697530e-02   6.5293471e-02   1.4228577e-01   2.7587241e-01   4.3365663e-01];
BLER4 = [ 2.9997000e-04   8.9991001e-04   7.3992601e-03   2.5897410e-02   8.1691831e-02];
BLER5 = [ 1.9998000e-04   1.6998300e-03   5.8994101e-03   3.1096890e-02   8.3991601e-02];
BLER6 = [  0.0000000e+00   2.9997000e-04   3.0996900e-03   1.2998700e-02   5.2194781e-02];
BLER7 = [0.0000000e+00   2.9997000e-04   2.0997900e-03   1.1298870e-02   5.1094891e-02];

figure(1);
h = semilogy(EbNodB,BER1,'-o',EbNodB,BER2,'--+',EbNodB,BER3,'.-.',EbNodB,BER4,'-*',EbNodB,BER5,'--.',EbNodB,BER6,'-^',EbNodB,BER7,'--v'); hold on; grid on; xlabel('EbNo dB');ylabel('BER'); title('Downlink E = 184; A = 50; QPSK');
axis([min(EbNodB) max(EbNodB) 1e-4 1e-1]); legend('Toolbox nL=4','SCL nL=4','SC','Toolbox nL=8','SCL nL=8','Toolbox nL=16','SCL nL=16'); 
set(h,'linewidth',1);
figure(2);
p = semilogy(EbNodB,BLER1,'-o',EbNodB,BLER2,'--+',EbNodB,BLER3,'.-.',EbNodB,BLER4,'-*',EbNodB,BLER5,'--.',EbNodB,BLER6,'-^',EbNodB,BLER7,'--v'); hold on; grid on; xlabel('EbNo dB');ylabel('BLER'); title('Downlink E = 184; A = 50; QPSK');
axis([min(EbNodB) max(EbNodB) 1e-4 1]); legend('Toolbox nL=4','SCL nL=4','SC','Toolbox nL=8','SCL nL=8','Toolbox nL=16','SCL nL=16'); 
set(p,'linewidth',1);