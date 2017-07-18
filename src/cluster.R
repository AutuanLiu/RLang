# 使用 K 均值聚类处理包含178种意大利葡萄酒中的13种化学成分的数据集

wssplot <- function(data, nc = 15, seed = 1234){
    wss <- (nrow(data) - 1) * sum(apply(data, 2, var))

    for (i in 2:nc){
        set.seed(seed)
        wss[i] <- sum(kmeans(data, centers = i)$withinss)
    }

    plot(1:nc, wss, type = "b", xlab = "Number of clusters", ylab = "within
     groups sum of squares")
}

data(wine, package = "rattle")
head(wind)
df <- scale(wine[-1])
wssplot(df)
library(Nbclust)
set.seed(1234)
devAskNewPage(ask = TRUE)
nc <- Nbclust(df, min.nc = 2, max.nc = 15, method = "Kmeans")

barplot(table(nc$Best.n[1, ]), xlab = "number of clusters", ylab = "number of
 criteria", main = "number of clusters chosen by 26 criteria")

set.seed(1234)
fit.km <- kmeans(df, 3, nstart = 25)
fit.km$size
fit.km$centers
aggergate(wine[-1], by = list(cluster = fit.km$cluster), mean)

ct.km <- table(wine$Type, fit.km$cluster)
ct.km
