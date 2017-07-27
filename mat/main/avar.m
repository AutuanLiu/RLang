function [out] = avar(value, dim)
% function:  计算适应度方差
favg = mean(value);
dif(dim) = 0;
for k = 1:dim
    dif(k) = abs(value(k)-favg);
end
maxdif=max(dif);
if maxdif>=1
    f=maxdif;
else
    f=1;
end
% 适应度方差
var = 0;
for k = 1:dim
    var = var + (dif(k)/f)^2;  % 适应度方差
end
out = var;
end  % function
