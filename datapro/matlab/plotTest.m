figure(1)
SI = HR ./ ABPSys;
% plot(ABPDias, 'r');
% hold on;
% plot(ABPSys, 'g');
% hold on;
plot(ABPMean, 'b');
hold on;
plot(HR, 'y');
hold on;
plot(SI, 'c');
legend( 'ABPMean', 'HR', 'SI')
