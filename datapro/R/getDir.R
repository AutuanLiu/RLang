#####
# Author: @AutuanLiu
# Date: 2017/07/26
#####

# 实现数据的处理和提取
setwd("D:/liuWork/R")
needABP.table <- read.csv("../data/needABP.csv", header = F, stringsAsFactors = F) 

# 目录名的获取与存储
dir.name <- apply(needABP.table, 2, getDirName)
write.csv(dir.name, "../data/dirNameofABP.csv")