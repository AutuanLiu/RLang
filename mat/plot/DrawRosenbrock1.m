function DrawRosenbrock1()
%绘制Rosenbrock函数图形
x=-8:0.1:8;
y=x;
[X,Y]=meshgrid(x,y);
[row,col]=size(X);
for l=1:col
    for h=1:row
        z(h,l)=Rosenbrock1([X(h,l),Y(h,l)]);
    end
end
surf(X,Y,z);
shading interp