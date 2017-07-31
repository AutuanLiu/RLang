function result=Schaffer(x1)
%Schaffer 函数
[row,col]=size(x1);
if row>1
    error('输入的参数错误');
end
x=x1(1,1);
y=x1(1,2);
temp=x^2+y^2;
result=0.5-(sin(sqrt(temp))^2-0.5)/(1+0.001*temp)^2;
