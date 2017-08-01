#####
# Author: @AutuanLiu
# Date: 2017/07/27
#####

# 数据的读取
setwd("D:/liuWork/R")
sharedID.table <- read.csv("../data/sharedID.csv", stringsAsFactors = F)
meanABP.table <- read.csv("../data/matchABP.csv", header = F, stringsAsFactors = F)
colnames(sharedID.table) <- c("index", "shared_id")
colnames(meanABP.table) <- c("file.have.ABP")

# id提取
id <- as.numeric(apply(meanABP.table, 2, cut.id))
mat.index <- getIndex(as.numeric(sharedID.table$shared_id), id)

# 匹配结果与存储
matchABP <- meanABP.table$file.have.ABP[mat.index]
write.csv(matchABP, "../data/difMatABP.csv")
