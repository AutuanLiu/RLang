function center = Initial_center(X,K)    
        N = size(X,2);  
        rnd_Idx = randperm(N);    
        center = X(:,rnd_Idx(1:K));    
end 