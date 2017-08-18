% figure(1);
% plot(cc, 'b')
% hold on;
% plot((cc-mean(cc))/std(cc),'r');
% hold on;
% plot((cc-min(cc))/(max(cc)-min(cc)),'g');
% legend('origin', 'z-score', 'min-max')
% figure(2);
% dd=sbp;
% dd(find(dd==0)) = mean(dd);
% plot(dd, 'b');
% hold on;
% plot((dd-mean(dd))/std(dd),'r');
% hold on;
% plot((dd-min(dd))/(max(dd)-min(dd)),'g');
% legend('origin', 'z-score', 'min-max')
% figure(3);
% ee=mbp;
% ee(find(ee==0))=mean(ee);
% plot(ee, 'b');
% hold on;
% plot((ee-mean(ee))/std(ee),'r');
% hold on;
% plot((ee-min(ee))/(max(ee)-min(ee)), 'g');
% legend('origin', 'z-score', 'min-max')
% figure(4)
% ff=cc./dd;
% plot((ff-min(ff))/(max(ff)-min(ff)))
% anline
subplot(4,1,1)
plot((cc-mean(cc))/std(cc));
legend('HR');
subplot(4,1,2)
plot((dd-mean(dd))/std(dd));
legend('SBP');
subplot(4,1,3)
plot((ff-mean(ff))/std(ff));
legend('MBP');
subplot(4,1,4)
plot((ee-mean(ee))/std(ee));
legend('SI');