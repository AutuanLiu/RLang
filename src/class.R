# 找出不存在的类
library(fMultivar)
library(ggplot2)
library(cluster)

set.seed(1234)
# 用于从相关系数为0.5的二元正态分布中抽取1000个观测值
df <- rnorm2d(1000, rho = .5)
df <- as.data.frame(df)
plot(df, main = "bivariate normal distribution with rho=0.5")
fit <- pam(df, k = 2)
df$clustering <- factor(fit$clustering)

ggplot(data = df, aes(x = V1, y = V2, color = clustering, shape = clustering)) + geom_point() + ggtitle("clustering of bivariate normal data")
