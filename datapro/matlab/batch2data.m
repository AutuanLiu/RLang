% Date: 2017/08/18
% @Author: AutuanLiu

% 本代码用于实现想要处理的csv文件的批量读入与转化
% 获取shock的发生时间片段并且保存

clc; 
clear all;
% 路径设置
dataDir = 'D:\liuWork\data\pro\sam\';
fileDir = 'D:\liuWork\data\pro\sam\*.csv';
file = dir(fileDir);
% cell 结构存储文件名1*1和数据2*1
file_name=cell(1,1);
file_data=cell(2,1);
% 获取信息hr&&sbp
for i = 1:size(file, 1)
    file_name{i, 1} = file(i).name;
    file_data{i, 1} = importdata([dataDir, file_name{i, 1}]);
    file_data{i, 1} = file_data{i, 1}.data;
end 

%  数据的保存
save('D:\liuWork\Matlab\data\shockdata.mat', 'file_data')

% 各个患者的shock的发生时间获取与保存
% load('D:\liuWork\Matlab\data\shockIDinfo.mat', 'shockIDinfo')
% save('D:\liuWork\Matlab\data\shockIDinfo.mat', 'shockIDinfo')
