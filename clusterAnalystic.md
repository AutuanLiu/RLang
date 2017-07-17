# 聚类分析
author: [@AutuanLiu](https://github.com/AutuanLiu)

date: 2017/07/17

info: based on R in Action(2nd editor)


聚类分析是一种数据归约技术，旨在揭露一个数据集中观测的子集。可以把大量的观测值归约为几个类
这里的类被定义为若干个观测值组成的集群，群组内的观测值的相似度比群间的观测值的相似度高
（**不是精确的定义，所以导致了各种聚类方法的出现**）

* 分类
1. 层次聚类 hierarchical agglomerative clustering

每个观测值自成一类，这些类每次两两合并，直到所有的类被聚成一类为止
算法 | 备注
--- | ---
single linkage | 单联动
complete linkage | 双联动
average linkage | 平均联动
centroid | 质心
Ward | 

2. 划分聚类 partitioning clustering

首先指定类的个数 K，然后观测值被随机分为 K 类，在重新聚合成新的类
算法 | 备注
--- | ---
K-means | K 均值算法
PAM | 围绕中心点划分

## 聚类分析的步骤
1. 选择合适的变量
2. 缩放数据
3. 寻找异常点
4. 计算距离
5. 选择聚类算法
6. 获得一种或多种聚类方法
7. 确定类的数目
8. 获得最终的聚类解决方案
9. 结果可视化
10. 解读类
11. 验证结果
### 缩放数据
```r
df1 <- apply(mydata, 2, function(x){(x - mean(x)/sd(x))})
df2 <- apply(mydata, 2, function(x){x/max(x)})
df3 <- apply(mydata, 2, function(x){(x - mean(x)/max(x))})
```
也可以使用scale()函数将变量标准化为均值0，标准差1的变量
### 计算距离
欧几里得距离

dist()：计算矩阵或数据框中所有行（观测值）之间的距离，默认计算欧氏距离
```r
dist(x, method =)
```
example:
```r
d <- dist(nutrient)
as.matrix(d)[1；4， 1:4]
```
观测值之间的距离越大，异质性越大，欧氏距离通常作为连续性数据的距离度量
```r
library(cluster)
daisy()
agnes()
pam()
```
**缩放数据有利于均衡各个变量之间的影响**

## 层次聚类
1. 定义每个观测值为一类
2. 计算每类和其他各类的距离
3. 把距离最短的两类合并成一类，这样类的个数就减少一个
4. 重复步骤2,3，直到包含所有观测值的类合并成单个的类为止

* 距离的定义
算法 | 备注 | 距离
--- | ---
single linkage | 单联动 | 一个类中的点和另一个类中的点的最小距离
complete linkage | 双联动 | 一个类中的点和另一个类中的点的最大距离
average linkage | 平均联动 | 一个类中的点和另一个类中的点的平均距离
centroid | 质心 | 两个类中质心之间的距离
Ward |  | 两个类中所有变量的方差分析的平方和

* 实现函数
```r
hclust(d, method =)
# d is a matrix make by dist()
# method = "sigle", "complete", "average", "centroid", "ward"
```
* 实现代码
nutrient.R
KValue.R
result.R

## 划分聚类分析
