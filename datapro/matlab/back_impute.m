function [imputed_data] = back_impute(data)
%% --------------------------------------------------------------
%  ------data为输入的待插值数据------
%  data为以下格式的矩阵: subject_id  intime_hour  valuenum
%  输入的data第二列（时间序列）的一部分对应的第三列（valuenum）没有值
%  用前向插值法将第三列为空的值补全
%% --------------------------------------------------------------
start_index = data(2:end,1) - data(1:end-1,1);
start_index = find(start_index~=0);   
patient_start =[1;start_index + 1];   %每个病人的第一行记录所在的行数
patient_end = [start_index;length(data)]; %每个病人最后一行记录所在行数
patient_id = unique(data(:,1));     %病人的ID号（subject_id）
%patient_start = [patient_id patient_start];
%patient_end = [patient_id patient_end];
wait_imputed = data;             %待插值数据
for i = length(patient_id):-1:1
    data_each_pat = [];
    pat_start_end = [];
    loc_NaN = [];
    data_each_pat = data(patient_start(i):patient_end(i),3);  %data_each_pat:第i个病人对应的数据值
    pat_start_end = [patient_start(i) : 1 : patient_end(i)]'; %pat_start_end:第i个病人测量起止位置
    loc_NaN = find(isnan(data_each_pat)) - 1 + patient_start(i);  %loc_NaN:NaN的位置
    loc_no_NaN = setdiff(pat_start_end,loc_NaN);  %loc_no_NaN:非空测量对应的位置
    len_NaN = length(loc_NaN);   
    len_no_NaN = length(loc_no_NaN);
    % =====================================================================
    %对待插值的数据进行后向插值
    if len_NaN ~= 0            %如果病人有空缺值,则进行插值
        if loc_NaN(len_NaN) == patient_end(i)
            for k = patient_end(i):-1:(loc_no_NaN(len_no_NaN) + 1)
                wait_imputed(k,3) = wait_imputed(loc_no_NaN(len_no_NaN),3);
            end
            k = len_NaN - (patient_end(i) - k) - 1;
            for m = k:-1:1
                wait_imputed(loc_NaN(m),3) = wait_imputed((loc_NaN(m)+1),3);
            end
        else
            for m = length(loc_NaN):-1:1
                wait_imputed(loc_NaN(m),3) = wait_imputed((loc_NaN(m)+1),3);
            end
        end  
    end
    % 插值完毕
    % =====================================================================
end
imputed_data = wait_imputed;
end

