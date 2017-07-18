# 使用PAM聚类处理包含178种意大利葡萄酒中的13种化学成分的数据集
library(cluster)
library(flexclust)

set.seed(1234)

fit.pam <- pam(wine[-1], k = 3, stand = TRUE)
fit.pam$medoids

clusplot(fit.pam, mian = "bivariate cluster plot")
ct.pam <- table(wine$Type, fit.pam$clustering)
randIndex(ct.pam)