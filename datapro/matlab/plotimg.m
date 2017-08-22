% Date: 2017/08/18
% @Author: AutuanLiu

% ���ڶ����ݽ�����ͼ
clc; clear all;
% ���ݵ�����
load('D:\liuWork\Matlab\data\shockdata.mat');

% �������ߵ�shock�ķ���ʱ���ȡ�뱣��
load('D:\liuWork\Matlab\data\shockIDinfo1.mat');

%  ���ݵĽ���
[len1, ~] = size(shockIDinfo1);
for id = 1:len1
    hrsbp = file_data{id, 1};
    hr = hrsbp(:, 1);
    sbp = hrsbp(:, 2);
    % shock�ļ�¼ʱ���ļ���
    % �����ʼ��¼��ʱ�� < 0�����ӵ� < 0 �Ĳ������ݣ��ÿ�ʼʱ��ľ���ֵ
    % + shockʱ��
    if shockIDinfo1(id, 3) < 0
        shock_record = shockIDinfo1(id, 5) * 60 + abs(shockIDinfo1(id, 3)) + 1;
        offset = shockIDinfo1(id, 3) + 1;
    elseif shockIDinfo1(id, 3) == 0
        shock_record = shockIDinfo1(id, 5) * 60 + 1;
        offset = 1;
    else
        shock_record = shockIDinfo1(id, 5) * 60 - shockIDinfo1(id, 3) + 1;
        offset = 0;
    end

    % �����Ƿ����Ҫ��
    filelen = shockIDinfo1(id, 2);
    % if filelen < shock_record
    %     shock_record = offset;
    % end

    % ��ʼʱ��
    start_record = shock_record - 30;
    if start_record <= 0
        start_record = 1;
    end
    
    % ����ʱ��
    end_record = shock_record + 30;
    if end_record > filelen
        end_record = filelen;
    end
    
    % t ������Ļ�ȡ
    [len2, ~] = size(hrsbp);
    off = shockIDinfo1(id, 3);
    t = (off:(off+len2-1));

    % ��ͼ
    pid = shockIDinfo1(id, 1);
    figure(id)
    plot(t/60, hrsbp);
    xlabel('ICUtime/h');
    ylabel('value');
    id2str = num2str(pid);
    legend([id2str, ' HR'], [id2str, ' SBP']);
    hold on;
    if shock_record > 0
        plot((off+shock_record-1)/60, hrsbp(shock_record, :), 'g^', 'MarkerSize', 8);
        hold on;
    end  
    leng2 = length(hrsbp);  
    line([min(t/60), max(t/60)], [90, 90]);
    x = [(start_record+off-1)/60, (start_record+off-1)/60, (end_record+off-1)/60, (end_record+off-1)/60];
    y = [60, 120, 120, 60];
    fill(x, y , 'b', 'facealpha', 0.5, 'edgecolor', 'none');
    hold off
end

% continue_interval_h([ones(length(hrsbp),1),[1:1:length(hrsbp)]'/60,hrsbp(:,2)] , 90, 0.5)
% aa = [ones(length(hrsbp),1),[1:1:length(hrsbp)]'/60,hrsbp(:,2)];
% bb = continue_interval_h(aa, 90, 0.5);