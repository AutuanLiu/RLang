 function [data_impute] = impute(data)

%---输入数据data：[subject_id, charttime_h, values]---------------------%
%---输出数据data_impute:[subject_id, charttime_h, values]---------------%

%---待插补矩阵data_no_impute(将开始提取出的数据中中间缺失的时间补齐)-------%
%---插补数据信息data_impute_info:[位置，值]------------------------------%

%---把所有的缺失时间对应的缺失值根据附近最临近值插补---%

%-----寻找新的待插补数据每个病人记录条数，以及起止位置-----%

id_loc_0 = [];
id_loc_1 = [];
id_loc_start = [];   
id_loc_end = [];  
pat_num = unique(data(:,1));  % pat_num:输入数据病人个数
data_no_impute = data;        %输入的数据中所有时间点已经补齐，只是有的时间点缺少测量值而已
id_loc_0 = data_no_impute(2:end,1) - data_no_impute(1:end-1,1);
id_loc_1 = find(id_loc_0 ~= 0);
id_loc_start = [1;id_loc_1 + 1];   % id_loc_start:每个病人开始记录的行数
id_loc_end = [id_loc_1;length(data_no_impute)];   % id_loc_end:每个病人记录的最后一条位置

%------开始插补数据------%
i = 0;
data_impute_info = []; %两列：[出现NaN的位置；要补入的数据]
%data_impute_info:最终插入到data_no_impute的位置和值
for i = 1:length(pat_num)
    data_each_pat = [];
    pat_start_end = [];
    loc_NaN = [];
    data_each_pat = data_no_impute(id_loc_start(i):id_loc_end(i),3);  %data_each_pat:第i个病人对应的数据值
    pat_start_end = [id_loc_start(i) : 1 : id_loc_end(i)]'; %pat_start_end:第i个病人测量起止位置
    loc_NaN = find(isnan(data_each_pat)) - 1 + id_loc_start(i);  %loc_NaN:NaN的位置
    loc_no_NaN = setdiff(pat_start_end,loc_NaN);  %loc_no_NaN:非空测量对应的位置
    %setdiff(A,B):求集合A和B的差集A-B
    j = 0;
    data_impute_0 = [];
    for j = 1:length(loc_NaN)  
        loc_need_0 = []; 
        loc_need = [];
        loc_need_0 = abs(data_no_impute(loc_NaN(j),2) - data_no_impute(loc_no_NaN,2));  %loc_need_0:为了寻找需要插补的位置的最近邻位置,是时间列      
        %loc_need_0(loc_NaN(j) + 1 - id_loc_start(i)) = Inf;
        loc_need = loc_no_NaN(find(loc_need_0 == min(loc_need_0)));
        data_impute_0(j,1) = loc_NaN(j);
        data_impute_0(j,2) = mean(data_no_impute(loc_need,3));
    end
    data_impute_info = [data_impute_info;data_impute_0];
end

data_impute = data_no_impute;
data_impute(data_impute_info(:,1),3) = data_impute_info(:,2);


