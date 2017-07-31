% 用于执行所有的程序
clc;
clear all;
close all;
% 初始化
particlesize = 50;  % 粒子群规模，即粒子数
pdim = 3;           % 粒子的维数，即寻优参数的个数
error = 0.001;      % 允许误差
itermax = 5000;     % 最大进化代数
c1 = 2.0;           % 学习因子1
c2 = 2.0;           % 学习因子2
w = 0.4;            % 惯性因子
delta1 = 5;         % 适应度方差条件
wmax = 0.8;
wmin = 0.2;
vmax = 2.0;         % 粒子的最大飞翔速度
% 粒子的初始位置
x=-10+20 * rand(particlesize, pdim);         % 粒子所在的位置(-10,10)
v=-2+4 * rand(particlesize, pdim);           % 粒子的飞翔速度(-2,2)
% 保存起来重复使用，使得几种算法使用同一初始化
p = x;
q = v;
%执行
bpso
case1
case2
% 图像数据处理1
plotiter1 = iter1-1+friter;
data1(plotiter1)=0;
for i = 1:iter1-1
    data1(i)=plotgbest1(i);
end
for i = iter1:plotiter1
    data1(i) = frval(i-iter1+1);
end
% 图像数据处理2
plotiter2 = iter2-1+friter1;
data2(plotiter2)=0;
for i = 1:iter2-1
    data2(i)=plotgbest2(i);
end
for i = iter2:plotiter2
    data2(i) = frval1(i-iter2+1);
end
data1 = sort(data1,'descend');
data2 = sort(data2,'descend');
% 画图
figure(1)
m = median([iter-1,plotiter1,plotiter2]);
t = 1:m;
plot(t, plotgbest(t), 'r-');
hold on;
 k= 1:plotiter1;
plot(k, data1(k), 'g--');
hold on;
 n = 1:plotiter2;
plot(n, data2(n), 'b-.');
title('三种算法的趋势比较图');
xlabel('epoch');
ylabel('gbest');
legend('PSO', 'case1', 'case2');
grid on;
hold off;
