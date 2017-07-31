#####
# Author: @AutuanLiu
# Date: 2017/07/26
#####

# 去掉不满足条件的id
setwd("D:/liuWork/R")
check.table <- read.csv("../data/filename.csv", header = F, stringsAsFactors = F)
check.set <- apply(check.table, 2, getDirName)

# 目录名去重
dir.unique <- unique(check.set)

# 统计目录的个数
num <- length(dir.unique)
# 2808

# 原始数据总共有2808个患者，结果显示批处理正确