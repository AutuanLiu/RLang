% afr: 共轭梯度法的实现
function [x,val,k] = afr(fun,x0)
% 基于Amrijo的共轭梯度法
% x0,fun分别是初始点，目标函数
% x,val,k   分别是近似最优点，最优值，迭代次数
maxi=5000;      % 最大迭代次数
rho=0.6;
delta=0.1;        % 保证数值梯度的精确
sigma=0.4;
k=0;
epsilon=1e-5;
n=length(x0);
while (k<maxi)
for i=1:n
    x1=x0(i) + delta;
    x2=x0(i) - delta;
    x3=x0;
    x4=x0;
    x3(i)=x1;
    x4(i)=x2;
    g(i)=(feval(fun, x3) - feval(fun, x4))/(2 * delta);
end
% g=g';
itern = k-(n+1)*floor(k/(n+1));
itern = itern+1;
% 计算搜索方向
if (itern == 1)
    d = -g';
else
    beta = (g'*g)/(g0'*g0);
    d = -g'+beta*d0;
    gd = g*d;
    if(gd >= 0.0)
        d = -g';
    end
end
if (norm(g') < epsilon)
    break;
end
%  检验终止条件
m = 0;
mk = 0;
while (m<100)  %  Armijo 搜索
    if (feval(fun,x0+rho^m*d) < feval(fun,x0)+sigma*rho^m*g*d)
        mk = m;
        break;
    end
    m = m+1;
end
x0 = x0+rho^mk*d;
g0 = g';
d0 = d;
k = k+1;
val(k) = feval(fun, x0);
end
x = x0;
end
