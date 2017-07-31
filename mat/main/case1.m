% 粒子群优化算法
tic;                                         % 程序运行计时
x = p;
v = q;
% 粒子的初始适应度
for i = 1:particlesize                       % 对每个粒子
    f(i) = fit_m(x(i, :));                   % 适应度，fit_m为适应度函数
end
Pbest = x;                                   % 粒子的最优位置
Pbestvalue = f;                              % 粒子的最优值
[Gbestvalue, index] = min(f);                % 全局最优值
Gbest = Pbest(index, :);                     % 全局最优位置
iter1 = 1;                                   % 迭代器
varf = avar(Pbestvalue, particlesize);       % 适应度方差
% 循环
while (iter1 <= itermax)                     % 小于最大迭代次数时迭代
  if(varf < delta1) % 适应度方差判断
      [frx, frval, friter] = afr('fit_m', Gbest');
      Gbestvalue = frval(length(frval));
      Gbest = frx';
      break;
  else
    for i = 1:particlesize
        f(i) = fit_m(x(i, :));
        if (f(i) < Pbestvalue(i))            % 判断是否是历史最佳位置
            Pbestvalue(i) = f(i);
            Pbest(i, :) = x(i, :);
        end
    end
    varf = avar(Pbestvalue, particlesize);   % 适应度方差
    [Gbestvalue, index] = min(Pbestvalue);   % 全局最优值
    plotgbest1(iter1) = Gbestvalue;          % 记录需要绘图的数据
    Gbest = Pbest(i, :);
    for i = 1:particlesize                   % 更新每个粒子的位置
      % w=wmax-(wmax-wmin)/itermax*iter1;    % 线性变化的惯性权重
      v(i, :) = w * v(i, :) + c1 * rand * (Pbest(i, :) - x(i, :)) + c2 * rand * (Gbest - x(i, :));                     % 更新速度
      for j = 1:pdim                         % 判断粒子的速度是否超过了最大速度
        if v(i, j) > vmax;
          v(i, j) = vmax;
        elseif v(i, j) < -vmax;
          v(i, j) = -vmax;
        end
      end
      x(i, :) = x(i, :) + v(i, :);
    end
    if (abs(Gbestvalue) < error)             % 是否停止迭代
      break;
    end
  end
    iter1 = iter1 + 1;                       % 迭代器递增
end
% 处理数据
value1 = num2str(Gbestvalue);
value2 = num2str(Gbest);
fprintf('\n');
fprintf('改进PSO的case1算法的执行结果:\n');
disp(strcat('最优位置为: ', value2));
disp(strcat('最优值为：', value1));
% 计时结束
toc;
