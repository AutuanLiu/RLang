function [best_Label,best_Center,best_ind,label] = KM(P,K,method)

%KM   K-Means Clustering or K-Medoids Clustering
%    P is an d-by-N data matrix 
%    K is the clustering number
%    method = KMeans    :K-Means Clustering
%           = KMedoids  :K-Medoids Clustering
%References：
%        1.The Elements of Statistical Learning 2nd Chapter14.3.6&&14.3.10

[d,N] = size(P); 
%% 本算法要求数据矩阵P的每列代表一个数据点，如果不是 需要转置矩阵
if d > N
    ButtonName = questdlg('数据维数小于点的个数,是否转置矩阵', 'MATLAB quest','Yes','No','Yes');
    if  strcmp(ButtonName, 'Yes')
        P = P';
        [d,N] = size(P); 
%     else
%         return
    end
end
    
%% 选取初始点 方法2 
max_Initial = max(20,N/(5*K));
label = zeros(max_Initial,N);
center = zeros(d,K,max_Initial);
C = zeros(1,N);
%% 主循环
for initial_Case = 1:max_Initial
    
    pointK = Initial_center(P,K);    
    iter = 0;
    max_iter = 1e+3;
    % xK = pointK;
    disp(['------------KM进行第 ' num2str(initial_Case) ' 次重新选择初始中心-----------'])
    %% 每次初始化K个中心点后，进行的循环
    while iter < max_iter
        iter = iter+1;
        if mod(iter,50)==0
            disp(['  内部循环进行第 ' num2str(iter) ' 次迭代'])
        end
        %%%根据数据矩阵P中每个点到中心点的距离(最小)确定所属分类
        for i = 1:N
            dert = repmat(P(:,i),1,K)-pointK;
            distK = sqrt(diag(dert'*dert));
            [~,j] = min(distK);
            C(i) = j;
        end
        %%%重新计算K个中心点  
        xK_ = zeros(d,K);
        for i = 1:K
            Pi = P(:,C==i);
            Nk = size(Pi,2);
            % K-Means K-Medoids唯一不同的地方：选择中心点的方式
            switch lower(method)
                case 'kmeans'  
                    xK_(:,i) = sum(Pi,2)/Nk;
                case 'kmedoids'
                    Dx2 = zeros(1,Nk);
                    for t=1:Nk
                       dx = Pi - Pi(:,t)*ones(1,Nk);
                       Dx2(t) = sum(sqrt(sum(dx.*dx,1)),2);
                    end
                    [~,min_ind] = min(Dx2);
                    xK_(:,i) = Pi(:,min_ind);
                otherwise
                    errordlg('请输入正确的方法：kmeans-OR-kmedoids','MATLAB error');
            end
        end
        
        % 判断是否达到结束条件
        if xK_==pointK   % & iter>50
            disp(['###迭代 ' num2str(iter) ' 次得到收敛的解'])
            label(initial_Case,:) = C;
            center(:,:,initial_Case) = xK_;
          % plot_Graph(C);
            break
        end
        
        pointK = xK_;
        %xK = xK_;
    end
    if iter == max_iter
         disp('###达到内部最大迭代次数1000,未得到收敛的解') 
         label(initial_Case,:) = C;
         center(:,:,initial_Case) = xK_;
        % plot_Graph(C);
         % break
    end
    
end

%%%%增加对聚类结果最优性的比较  
%距离差
 dist_N = zeros(max_Initial,K);
 for initial_Case=1:max_Initial     
     for k=1:K
         tem = find(label(initial_Case,:)==k);
         dx = P(:,tem)-center(:,k,initial_Case)*ones(1,size(tem,2));
         dxk = sqrt(sum(dx.*dx,1));
         dist_N(initial_Case,k) = sum(dxk);       
         % dist_N(initial_Case,k) = dxk;   
     end     
 end
 
 %%%%对于max_Initial次初始化中心点得到的分类错误
 %%%%取错误最小的情况的Label作为最终分类
 dist_N_sum = sum(dist_N,2); %求K类总的误差
 [~,best_ind] = min(dist_N_sum);
 best_Label = label(best_ind,:); 
 best_Center = center(:,:,best_ind);
 
