function result=Rosenbrock1(x)
%Rosenbrock 函数
[row,col]=size(x);
if row>1
    error('输入的参数错误');
end
result=100*(x(1,2)-x(1,1)^2)^2+(x(1,1)-1)^2;
result=-result;
