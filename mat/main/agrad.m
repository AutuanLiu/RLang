% agrad: 最速下降法的算法实现
function [x,val,k] = agrad(fun,x0)
% 基于Amiji的最速下降法
% x0 是初始点，fun 是目标函数
% x,val,k 分别是近似最优点和最优值，迭代次数
maxk=5000;              %最大迭代次数
rho=0.5;
sigma=0.4;
delta=0.1;        % 保证数值梯度的精确
k=1;
epsilon=1e-5;
n=length(x0);
while (k<maxk)
% 计算数值梯度
  for i=1:n
    x1=x0(i) + delta;
    x2=x0(i) - delta;
    x3=x0;
    x4=x0;
    x3(i)=x1;
    x4(i)=x2;
    g(i)=(feval(fun, x3) - feval(fun, x4))/(2 * delta);
  end
  d=-g';      % 计算搜索方向，负梯度
  if (norm(d)<epsilon)
    break;
  end
  m=0;
  mk=0;
  while (m<20)     % Armijio 搜索
    if (feval(fun,x0+rho^m*d)<feval(fun,x0)+sigma*rho^m*g*d)
      mk=m;
      break;
    end
    m=m+1;
  end
    x0=x0+rho^mk*d;
    val(k)=feval(fun,x0);
    k=k+1;
end
x=x0;
end
