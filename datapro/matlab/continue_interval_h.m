function [loc_data]=continue_interval_h(data , range, interval)

%--1.calculate the number of patients--%
pat_loc_start = []; pat_loc_end = []; pat_id = [];  
pat_loc_end = find((data(2:end,1) - data(1:end-1,1)) ~= 0);
pat_loc_end = [pat_loc_end;length(data(:,1))];  %pat_loc_end: each patient records end location
pat_loc_start = find((data(2:end,1) - data(1:end-1,1)) ~= 0) + 1;
pat_loc_start = [1;pat_loc_start]; %pat_loc_start: each patient records start location
pat_id = data(pat_loc_start,1); %pat_id: patients subject_id

%--2.calculate the location of data < range with duration least 30 min --%
%--2.1 change data's value to 1 or 0 (1:data < range; 0:data > range)
data_01 = data;  % convenient to change data value
data(find(data_01(:,3) < range),3) = 1;
data(find(data_01(:,3) >= range),3) = 0;
data_01 = [];

%--2.2 find loctations of data continuous lower range
i = 0;
loc_data_start = []; loc_data_end = []; loc_pat_id = []; loc_data = [];
time_data_start = []; time_data_end = [];
for i = 1 : length(pat_id)
    data_each = []; loc_data_0 = []; loc_data_01 = []; loc_data_start_0 = []; loc_data_end_0 = [];
    loc_data_1 = []; loc_data_2 = []; loc_data_3 = []; loc_pat_id_0 = [];
    time_data_end_0 = []; time_data_start_0 = [];
    data_each = data(pat_loc_start(i):pat_loc_end(i),:);  % data_each: each patient's data
    loc_data_0 = find((data_each(2:end,3) - data_each(1:end-1,3)) == 0); 
    if ~isempty(loc_data_0)
        loc_data_0(find(data_each(loc_data_0,3) == 0)) = []; % loc_data_0: each patient's the inital location of needing
        if length(loc_data_0) > 1
           loc_data_01 = unique([loc_data_0 + 1;loc_data_0]);
           loc_data_0 = sort(loc_data_01);
           loc_data_1 = find((loc_data_0(2:end) - loc_data_0(1:end-1)) ~= 1); %loc_data_1: find loctation of block(data < range)
           if ~isempty(loc_data_1)
               loc_data_2 = [loc_data_1;length(loc_data_0)];
               loc_data_end_0 = loc_data_0(loc_data_2);
               loc_data_3 = [1;loc_data_1 + 1];
               loc_data_start_0 = loc_data_0(loc_data_3);
               loc_pat_id_0 = pat_id(i) * ones(length(loc_data_start_0),1);
               time_data_end_0 = data_each(loc_data_end_0,2);
               time_data_start_0 = data_each(loc_data_start_0,2);
               loc_data_end_0 = loc_data_end_0 + pat_loc_start(i) - 1;
               loc_data_start_0 = loc_data_start_0 + pat_loc_start(i) - 1;
           else
               loc_data_start_0 = loc_data_0(1);
               loc_data_end_0 = loc_data_0(end);
               loc_pat_id_0 = pat_id(i) * ones(length(loc_data_start_0),1);
               time_data_end_0 = data_each(loc_data_end_0,2);
               time_data_start_0 = data_each(loc_data_start_0,2);
               loc_data_end_0 = loc_data_end_0 + pat_loc_start(i) - 1;
               loc_data_start_0 = loc_data_start_0 + pat_loc_start(i) - 1;
           end
        else
            if length(loc_data_0) == 1
                loc_data_start_0 = loc_data_0(1);
                loc_data_end_0 = loc_data_0(1) + 1;
                loc_pat_id_0 = pat_id(i) * ones(length(loc_data_start_0),1);
                time_data_end_0 = data_each(loc_data_end_0,2);
                time_data_start_0 = data_each(loc_data_start_0,2);
                loc_data_end_0 = loc_data_end_0 + pat_loc_start(i) - 1;
                loc_data_start_0 = loc_data_start_0 + pat_loc_start(i) - 1;
            end            
        end
    end
 
  loc_data_start = [loc_data_start;loc_data_start_0];
  loc_data_end = [loc_data_end;loc_data_end_0];
  loc_pat_id = [loc_pat_id;loc_pat_id_0];
  time_data_start = [time_data_start;time_data_start_0];
  time_data_end = [time_data_end;time_data_end_0];
  
end

loc_data = [loc_pat_id, loc_data_start, time_data_start, loc_data_end, time_data_end]; 
%loc_data£º[subject_id, data_range_con_start, time_data_range_con_start, data_range_con_end, time_data_range_con_end];

loc_data(find((loc_data(:,5) - loc_data(:,3)) < interval),:) = []; %exclude continue time < interval h





