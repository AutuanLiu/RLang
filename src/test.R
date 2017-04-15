# 体重
X1<-c(35, 40, 40, 42, 37, 45, 43, 37, 44, 42, 41, 39)
mean(X1) # 计算均值
sd(X1) 
# 胸围
X2<-c(60, 74, 64, 71, 72, 68, 78, 66, 70, 65, 73, 75)
mean(X2)
sd(X2) # 计算标准差
plot(X1,X2) # 画散点图
hist(X1) # 画直方图
hist(X2)
# 读取文件
rt<-read.table("exam.txt", head=TRUE); rt
lm.sol<-lm(Weight~Height, data=rt)
summary(lm.sol)
#自定义函数与调用
f<-function(x,y)
{
  c(x+1,exp(y))
}
# 调用
f(2,3)
# 数据结构
w<-array(c(1:18),c(3,3,2)) # 数组
m<-matrix(c(1:12),3,4) # 矩阵
w[1:2,2:3,1]
# list
e<-list(thing="hat",size="8.25")
# data frame
# 其结果就是产生一个table
teams<-c("PHI","NYM","FLA","ATL","WSN")
w<-c(92,89,94,72,59)
l<-c(70,73,77,90,102)
n<-data.frame(teams,w,l)
# display
n
if(1 > 2)
  "yes" else
    "no"
127 %% 4
typeof(as(1,"integer"))  
  
  
