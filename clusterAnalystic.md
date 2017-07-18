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
观测值被分为 K 组并根据给定的规则改组成最有粘性的类

### K 均值聚类

* 步骤
    1. 选择 K 个中心点（随机选择 K 行）
    2. 把每个数据点分派到离它最近的中心点
    3. 重新计算每类中的点到该类中心点距离的平均值
    4. 分派每个数据到它最近的中心点
    5. 重复步骤3， 4 直到所有的观测值不再被分派或是达到最大的迭代次数（Hartigan&Wong）

主要采用Hartigan&Wong的算法，这种算法是把观测值分为 K 组，并使得观测值到指定的聚类中心的平方的总和最小。

K 均值聚类能处理比层次聚类更大的数据集。另外，观测值不会被永远分到一类中， 当我们提高整体解决方案时，聚类方案
也会改变。但是，均值的使用意味着所有的变量必须是连续的，并且这个方法很可能被异常值影响。它在非凸聚类情况下，甚至变得更差
```r
kmeans(x, centers)
```
由于k均值聚类在开始要随机选择k个中心点，在每次调用函数时可能获得不同的方案。使用`set.seed()`函数可以保证结果的可复现
性。此外，剧烈方法对初始中心值的选择也很敏感

* 参考程序
```r
# data 参数用来分析的数据，nc是要考虑的最大聚类个数，seed是一个随机种子
wssplot <- function(data, nc = 15, seed = 1234){
    wss <- (nrow(data) - 1) * sum(apply(data, 2, var))

    for (i in 2:nc){
        set.seed(seed)
        wss[i] <- sum(kmeans(data, centers = i)$withinss)
    }

    plot(1:nc, wss, type = "b", xlab = "Number of clusters", ylab  = "within groups sum of squares")
}
```
详见 cluster.R

由于变量值变化过大，所以在聚类前要将其标准化

`aggregate()`函数用于得到原始矩阵的每一类的变量均值

`兰德指数（Rand index）`用于量化类型变量和类之间的协议

```r
library(flexclust)
randIndex(ct.km)
```

### 中心点划分PAM
PAM使用任意的距离来计算

* 步骤
    1. 随机选择k个观测值
    2. 计算观测值到各个中心点的距离相异性
    3. 把每个观测值分配到最近的中心点
    4. 计算每个中心点到每个观测值的距离的总和（总成本）
    5. 选择一个该类中不是中心的点，并和中心点互换
    6. 重新把每个点分派到距它最近的中心点
    7. 再次计算总成本
    8. 如果总成本比步骤4计算的总成本少，把新的点作为中心点
    9. 重复步骤 5～8 直到中心点不再改变

cluster包的pam()函数可以实现这一个功能
```r
library(cluster)
# x 为数据， k为聚类个数， metrix 表示相似性或相异性矩阵，stand 表示是否需要进行标准化
pam(x, k, metrix = "euclidean", stand = FALSE)
``` 

