# sample test
# Author: @AutuanLiu
# Date: 2017/07/25
library(ggplot2)
sample <- read.csv(file = "~/fivesam1.csv")
ggplot(data = sample, aes(x = index, y = s682)) +
 geom_point(pch = 1, color = "blue", size = 2) +
 geom_smooth(method = "lm", color = "red", linetype = 2) +
 labs(title = "Automobile data", x = "Weight", y = "Miles per gallon")

