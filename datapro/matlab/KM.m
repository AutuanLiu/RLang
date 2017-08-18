function [best_Label,best_Center,best_ind,label] = KM(P,K,method)

%KM   K-Means Clustering or K-Medoids Clustering
%    P is an d-by-N data matrix 
%    K is the clustering number
%    method = KMeans    :K-Means Clustering
%           = KMedoids  :K-Medoids Clustering
%References��
%        1.The Elements of Statistical Learning 2nd Chapter14.3.6&&14.3.10

[d,N] = size(P); 
%% ���㷨Ҫ�����ݾ���P��ÿ�д���һ�����ݵ㣬������� ��Ҫת�þ���
if d > N
    ButtonName = questdlg('����ά��С�ڵ�ĸ���,�Ƿ�ת�þ���', 'MATLAB quest','Yes','No','Yes');
    if  strcmp(ButtonName, 'Yes')
        P = P';
        [d,N] = size(P); 
%     else
%         return
    end
end
    
%% ѡȡ��ʼ�� ����2 
max_Initial = max(20,N/(5*K));
label = zeros(max_Initial,N);
center = zeros(d,K,max_Initial);
C = zeros(1,N);
%% ��ѭ��
for initial_Case = 1:max_Initial
    
    pointK = Initial_center(P,K);    
    iter = 0;
    max_iter = 1e+3;
    % xK = pointK;
    disp(['------------KM���е� ' num2str(initial_Case) ' ������ѡ���ʼ����-----------'])
    %% ÿ�γ�ʼ��K�����ĵ�󣬽��е�ѭ��
    while iter < max_iter
        iter = iter+1;
        if mod(iter,50)==0
            disp(['  �ڲ�ѭ�����е� ' num2str(iter) ' �ε���'])
        end
        %%%�������ݾ���P��ÿ���㵽���ĵ�ľ���(��С)ȷ����������
        for i = 1:N
            dert = repmat(P(:,i),1,K)-pointK;
            distK = sqrt(diag(dert'*dert));
            [~,j] = min(distK);
            C(i) = j;
        end
        %%%���¼���K�����ĵ�  
        xK_ = zeros(d,K);
        for i = 1:K
            Pi = P(:,C==i);
            Nk = size(Pi,2);
            % K-Means K-MedoidsΨһ��ͬ�ĵط���ѡ�����ĵ�ķ�ʽ
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
                    errordlg('��������ȷ�ķ�����kmeans-OR-kmedoids','MATLAB error');
            end
        end
        
        % �ж��Ƿ�ﵽ��������
        if xK_==pointK   % & iter>50
            disp(['###���� ' num2str(iter) ' �εõ������Ľ�'])
            label(initial_Case,:) = C;
            center(:,:,initial_Case) = xK_;
          % plot_Graph(C);
            break
        end
        
        pointK = xK_;
        %xK = xK_;
    end
    if iter == max_iter
         disp('###�ﵽ�ڲ�����������1000,δ�õ������Ľ�') 
         label(initial_Case,:) = C;
         center(:,:,initial_Case) = xK_;
        % plot_Graph(C);
         % break
    end
    
end

%%%%���ӶԾ����������ԵıȽ�  
%�����
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
 
 %%%%����max_Initial�γ�ʼ�����ĵ�õ��ķ������
 %%%%ȡ������С�������Label��Ϊ���շ���
 dist_N_sum = sum(dist_N,2); %��K���ܵ����
 [~,best_ind] = min(dist_N_sum);
 best_Label = label(best_ind,:); 
 best_Center = center(:,:,best_ind);
 
