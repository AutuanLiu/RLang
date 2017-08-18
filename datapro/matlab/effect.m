% HR的缺失值较多，15683号患者，0.134467801	, 0.037370704
% SBP的缺失值较多，12141号患者，0.002787734	, 0.116288331
% HR, SBP的缺失值较多，14298号患者，0.110850095	, 0.106445456
% 发生休克，入ICU31小时，308号患者，0.011832524	0.060072816
% 使用z-score进行标准化
figure(1)
subplot(2,1,1)
plot(HR1, 'b')
hold on;
plot(HRintered1, 'g')
hold off;
% legend('initial HR ',' interpolation HR')

subplot(2,1,2)
plot(ABPSys1, 'b')
hold on;
plot(SBPintered1, 'g')
hold off;
legend('15683 initial SBP value','15683 interpolation SBP value')

figure(2)
subplot(2,1,1)
plot(HR2, 'b')
hold on;
plot(HRintered2, 'g')
hold off;
legend('12141 initial HR value','12141 interpolation HR value')

subplot(2,1,2)
plot(ABPSys2, 'b')
hold on;
plot(SBPintered2, 'g')
hold off;
legend('12141 initial SBP value','12141 interpolation SBP value')

figure(3)
subplot(2,1,1)
plot(HR3, 'b')
hold on;
plot(HRintered3, 'g')
hold off;
legend('14298 initial HR value','14298 interpolation HR value')

subplot(2,1,2)
plot(ABPSys3, 'b')
hold on;
plot(SBPintered3, 'g')
hold off;
legend('14298 initial SBP value','14298 interpolation SBP value')

figure(4)
subplot(2,1,1)
plot(HR4, 'b')
hold on;
plot(HRintered4, 'g')
hold off;
legend('308 initial HR value','308 interpolation HR value')

subplot(2,1,2)
plot(ABPSys4, 'b')
hold on;
plot(SBPintered4, 'g')
hold off;
legend('308 initial SBP value','308 interpolation SBP value')

figure(5)
subplot(4,1,1)
plot((HRintered1-mean(HRintered1))/std(HRintered1),'b')
hold on;
plot((SBPintered1-mean(SBPintered1))/std(SBPintered1),'g')
hold off;

subplot(4,1,2)
plot((HRintered2-mean(HRintered2))/std(HRintered2),'b')
hold on;
plot((SBPintered2-mean(SBPintered2))/std(SBPintered2),'g')
hold off;

subplot(4,1,3)
plot((HRintered3-mean(HRintered3))/std(HRintered3),'b')
hold on;
plot((SBPintered3-mean(SBPintered3))/std(SBPintered3),'g')
hold off;

subplot(4,1,4)
plot((HRintered4-mean(HRintered4))/std(HRintered4),'b')
hold on;
plot((SBPintered4-mean(SBPintered4))/std(SBPintered4),'g')
hold off;

figure(6)
l = length(HRintered1);
x = 1:l;
y = HRintered1;
p = polyfit(x',y,1);
p1 = polyval(p,x');

plot(p1);
hold on;
plot(HRintered1);
hold on;
plot((HRintered1 - p1));
hold off;

