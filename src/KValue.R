# 确定分类的类数
library(Nbclust)
devAskNewPage(ask = TRUE)
nc <- Nbclust(nutrient.scaled, distance = "euclidean", min.nc = 2, max.nc = 15, method = "average")
table(nc$Best.n[1,])
barplot(table(nc$Best.n[1,]), xlab = "number of clusters", ylab = "number of criteria", main = "result")