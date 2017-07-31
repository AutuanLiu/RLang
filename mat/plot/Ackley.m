function result=Ackley(x)
%Ackley 函数
[row,col]=size(x);
if row>1
    error('输入的参数错误');
end
result=-20*exp(-0.2*sqrt((1/col)*(sum(x.^2))))-exp((1/col)*sum(cos(2*pi.*x)))+exp(1)+20;
result=-result;
