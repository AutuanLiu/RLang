function [imputed_data] = forward_impute(data,max_time)
%% --------------------------------------------------------------
%  ------data为输入的待插值数据，max_time为每个患者对应的最大测量时间------
%  data为以下格式的矩阵: subject_id  intime_hour  valuenum
%  输入的data第二列（时间序列）的一部分对应的第三列（valuenum）没有值
%  用前向插值法将第三列为空的值补全
%% --------------------------------------------------------------
start_rows = data(2:end,1) - data(1:end-1,1);
start_rows = find(start_rows~=0);   
pat_start = [1;start_rows + 1];   %每个病人的第一行记录所在的行数
pat_end = [start_rows;length(data)]; %每个病人最后一行记录所在行数
patient_id = unique(data(:,1));     %病人的ID号（subject_id）
pat_num = length(patient_id);   %病人个数
%  ------------------------把中间缺失的小时补充--------------------------
data_no_impute = []; % data_no_impute:将中间缺失的时间值找到，构建成待插补的数据
for i = 1 : pat_num
    full_h = [0:1:max_time(i)]'; %full_h：每个病人对应的计算sirs的时间/h
    missing_h = setdiff(full_h,data(pat_start(i):pat_end(i),2)); %missing_h:每个病人缺失的时间
    missing_data = [patient_id(i)* ones(length(missing_h),1), missing_h, 0*ones(length(missing_h),1)];   %生理值也可能为0,值为0的作为缺失值
    data_no_impute_0 = [data(pat_start(i):pat_end(i),:);missing_data];
    data_no_impute_0 = sortrows(data_no_impute_0,2);  %data_no_impute_0:将每个病人的数据按时间由小到大排序
    data_no_impute_0(find(data_no_impute_0(:,3) == 0),3) = NaN;
    data_no_impute = [data_no_impute;data_no_impute_0];  %data_no_impute:最终所有病人将缺失时间补充好的待插补数据
end
%  --------------------------------------------------------------------
%  ----------------将时间序列补充完整的数据进行插值----------------------
wait_imputed = data_no_impute;             %待插值数据
start_index = wait_imputed(2:end,1) - wait_imputed(1:end-1,1);
start_index = find(start_index~=0);   
patient_start =[1;start_index + 1];   %每个病人的第一行记录所在的行数
patient_end = [start_index;length(wait_imputed)]; %每个病人最后一行记录所在行数
patient_id = unique(wait_imputed(:,1));     %病人的ID号（subject_id）

for i = 1:length(patient_id)
    data_each_pat = [];
    data_each_pat = wait_imputed(patient_start(i):patient_end(i),3);  %data_each_pat:第i个病人对应的数据值
    pat_start_end = [patient_start(i) : 1 : patient_end(i)]'; %pat_start_end:第i个病人测量起止位置
    loc_NaN = find(isnan(data_each_pat)) - 1 + patient_start(i);  %loc_NaN:NaN的位置
    loc_no_NaN = setdiff(pat_start_end,loc_NaN);  %loc_no_NaN:非空测量对应的位置
%     count = 1;           %每次都将病人需要用到的插补值个数置为1
    % 计算病人用前向插值时，需要用到的用于插补的测量值的个数，记为count
%     for l = 2:length(loc_NaN)
%         if (loc_NaN(l) - loc_NaN(l-1)) ~= 1
%             count = count + 1;
%         end
%     end
    % =====================================================================
    %对待插值的数据进行前向插值
    if (length(loc_NaN)) ~= 0            %如果病人有空缺值
        if loc_NaN(1) == patient_start(i)
            for k = patient_start(i):(loc_no_NaN(1) - 1)
                wait_imputed(k,3) = wait_imputed(loc_no_NaN(1),3);
            end
            k = k - patient_start(i) + 2;
            for m = k:(length(loc_NaN))
%                if (loc_NaN(m+1)-loc_NaN(m))~=1
%                    wait_imputed(loc_NaN(m+1)) = wait_imputed(loc_NaN(m+1)-1);
%                else
                wait_imputed(loc_NaN(m),3) = wait_imputed((loc_NaN(m)-1),3);
            end
        else
            for m = 1:length(loc_NaN)   
                wait_imputed(loc_NaN(m),3) = wait_imputed((loc_NaN(m)-1),3);
            end
        end  
    end
    % 插值完毕
    % =====================================================================
end
imputed_data = wait_imputed;
end

% %  full_time_data 用来将患者的时间序列补充完整，并作为待插值数据
% %  max_time为所有患者的最大时间值的和，由于病人最初是从0小时开始计数，所以需要再加上病人数量
% full_time_data = zeros((max_time+patient_num),3);
% full_time_data(1:(max_time+1),1) = patient(1);
% full_time_data(1:(max_time+1),2) = [0:1:max_time(1)]';
% for i = 2:patient_num
%     start_rows = i - 1 + sum(max_time(1:i-1));
%     end_rows = start_rows + max_time(i);
%     full_time_data(start_rows:end_rows,1) = patient_id(i);
%     full_time_data(start_rows:end_rows,2) = [0:1:max_time(i)]';
% end
% start_index = full_time_data(2:end,1) - full_time_data(1:end-1,1);
% start_index = find(start_index~=0);   
% patient_start = [1;start_index + 1];   %每个病人的第一行记录所在的行数
% patient_end = [start_index;length(full_time_data)]; %每个病人最后一行记录所在行数
% for i = 1:patient_num
%     loc_data = data(pat_start(i):pat_end(i),2);       %  数据中原有时间
%     for j = patient_start(i):patient_end(i)

