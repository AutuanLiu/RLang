library(ggplot2)
# pch = 17 表示三角形，geome_smooth表示光滑方法
# 95%的置信区间
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
 geom_point(pch = 17, color = "blue", size = 2) +
 geom_smooth(method = "lm", color = "red", linetype = 2) +
 labs(title = "Automobile data", x = "Weight", y = "Miles per gallon")

