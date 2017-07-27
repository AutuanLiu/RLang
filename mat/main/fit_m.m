% 适应度函数
function y = fit_m(x)
[r,c] = size(x);
%选择一个测试函数
term1 = 0;
for i = 1:c
  term1 = term1+ x(r,i)^2-10*cos(2*pi*x(r,i))+10 ; % Rastrigin 函数
end
y = term1;
end
