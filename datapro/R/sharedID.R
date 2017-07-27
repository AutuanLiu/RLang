#####
# Author: @AutuanLiu
# Date: 2017/07/26
#####

# id的匹配
setwd("D:/liuWork/R")
notNA.table <- read.csv("../data/notNA.csv", stringsAsFactors = F)
matchID.table <- read.csv("../data/matchID.csv", stringsAsFactors = F)

# 数据提取与保存
id <- as.numeric(apply(matchID.table, 2, cut.id))
shared.id <- intersect(id, notNA.table$subject_id)
write.csv(shared.id, "../data/sharedID.csv")