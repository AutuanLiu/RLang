#####
# Author: @AutuanLiu
# Date: 2017/07/26
#####

# 实现数据的处理和提取
setwd("D:/liuWork/R")
data1 <- read.csv("../data/resCSV/s06042-2828-10-13-18-23n.hea.csv", header = TRUE, stringsAsFactors = FALSE)
y <- data1$X.HR.
y <- y[-1]
y <- as.numeric(y)
plot(y, type = "l")
