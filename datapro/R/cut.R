#####
# Author: @AutuanLiu
# Date: 2017/07/26
#####

# 去掉不满足条件的id
setwd("D:/liuWork/R")
com.table <- read.csv("../data/difTime.csv", stringsAsFactors = F)
file.table <- read.csv("../data/filename.csv", header = F, stringsAsFactors = F)
backup <- com.table
com.table$deltaTime[com.table$deltaTime < 0] <- NA

# 去掉含有NA值的行
na.index <- idx(com.table$deltaTime)
com.table <- com.table[-na.index, ]

# 保存数据
write.csv(com.table, "../data/notNA.csv")

# 处理可能很重要的 difTime < 0 的信息
negative.index <- neidx(backup$deltaTime)

# 保存 < 0 的表格
ne.file <- file.table[negative.index, ]
write.csv(ne.file, "../data/neFile.csv")

