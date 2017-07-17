# 层次聚类
library(flexclust)

data(nutrient)
row.names(nutrient) <- tolower(row.names(nutrient))
nutrient.scaled <- scale(nutrient)
d <- dist(nutrient.scaled)
fit.average <- hclust(d, method = "average")
plot(fit.average, hang = -1, cex = .8, main = "Average Linkage Clustering")