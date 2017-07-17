# 层次聚类的结果
# 先执行 nutrient.R
clusters <- cutree(fit.average, k = 5)
table(clusters)
aggregate(nutrient, by = list(cluster = clusters), median)
aggregate(as.data.frame(nutrient.scaled), by = list(cluster = clusters), median)
plot(fit.average, hang = -1, cex = .8, main = "average linkage clustering\n 5 cluster solution")
rect.hclust(fit.average, k = 5)