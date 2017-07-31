#####
# Author: @AutuanLiu
# Date: 2017/07/29
#####

# 去掉没有ABP的负值csv
setwd("D:/liuWork/R")
abp.table <- read.csv("../data/matchABP.csv", header = F, stringsAsFactors = F)
necsv.table <- read.csv("../data/neCSVName.csv", header = F, stringsAsFactors = F)
necut.table <- read.csv("../data/necut.csv", header = F, stringsAsFactors = F)

# 取交集
ne.Abp <- intersect(necsv.table[, 1], abp.table[, 1])
ne.Abp1 <- intersect(necut.table[, 1], abp.table[, 1])

# 保存
write.csv(ne.Abp1, "../data/neABPneed.csv")