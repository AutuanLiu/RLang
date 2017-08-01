#####
# Author: @AutuanLiu
# Date: 2017/08/01
#####

# 查找丢失
setwd("D:/liuWork/R")
notna <- read.csv("../data/notNA1.csv", stringsAsFactors = F)

# save
filename <- notna[, 2]
write.csv(filename, "../data/finalFilename.csv")