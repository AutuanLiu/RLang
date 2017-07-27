function DrawSchaffer()
x=[-5:0.05:5];
y=x;
[X,Y]=meshgrid(x,y);
[row,col]=size(X);
for l=1:col
for h=1:row
z(h,l)=Schaffer([X(h,l),Y(h,l)]);
end
end
surf(X,Y,z);
shading interp