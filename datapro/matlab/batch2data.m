% Date: 2017/08/18
% @Author: AutuanLiu

% ����������ʵ����Ҫ�����csv�ļ�������������ת��
% ��ȡshock�ķ���ʱ��Ƭ�β��ұ���

clc; 
clear all;
% ·������
dataDir = 'D:\liuWork\data\pro\sam\';
fileDir = 'D:\liuWork\data\pro\sam\*.csv';
file = dir(fileDir);
% cell �ṹ�洢�ļ���1*1������2*1
file_name=cell(1,1);
file_data=cell(2,1);
% ��ȡ��Ϣhr&&sbp
for i = 1:size(file, 1)
    file_name{i, 1} = file(i).name;
    file_data{i, 1} = importdata([dataDir, file_name{i, 1}]);
    file_data{i, 1} = file_data{i, 1}.data;
end 

%  ���ݵı���
save('D:\liuWork\Matlab\data\shockdata.mat', 'file_data')

% �������ߵ�shock�ķ���ʱ���ȡ�뱣��
% load('D:\liuWork\Matlab\data\shockIDinfo.mat', 'shockIDinfo')
% save('D:\liuWork\Matlab\data\shockIDinfo.mat', 'shockIDinfo')
