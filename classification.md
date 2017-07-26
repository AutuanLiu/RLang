# 分类

> 1. 决策树分类
> 1. **随机森林**进行集成分类
> 1. 生成支持向量机模型
> 1. 评价分类准确性

有监督机器学习领域包含许多可用于分类的方法，如

1. 逻辑回归
1. 决策树
1. 随机森林
1. 支持向量机
1. 神经网络

通过 rpart,rpart.plot和party包来实现决策树模型及其可视化，通过randomForest包拟合随机森林，通过e1071包构造支持向量机

## 数据准备

随机分为训练集与测试集，其中训练集包含499个样本单元，其中良性样本单元329个，恶性160；验证集包含210个样本单元，其中良性129个，
恶性81个

```r
loc <- "http:/archive.ics.uci.edu/ml/machine-learning-databases/"
ds <- "breast-cancer-wisconsin/breast-cancer-wisconsin.data"
url <- paste(loc, ds, sep = "")

breast <- read.table(url, sep = ",", header = FALSE, na.string = "?")
names(breast) <- c("ID", "clumpThickness", "sizeUniformity", "shapeUniformity",
 "maginalAdhesion", "singleEpithelialCellSize", "bareNuclei", "blandChromatin",
  "normalNucleoli", "mitosis", "class")
df <- breast[-1]
df$class <- factor(df$class, levels = c(2, 4), labels = c("benign", "malignant"))
set.seed(1234)
train <- sample(nrow(df), 0.7 * nrow(df))
df.train <- df[train, ]
df.valodate <- df[-train, ]
table(df.train$class)
table(df.validate$class)
```