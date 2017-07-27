#####
# Author: @AutuanLiu
# Date: 2017/07/26
#####

# id的匹配
setwd("D:/liuWork/R")
notNA.table <- read.csv("../data/notNA.csv", stringsAsFactors = F)
matchID.table <- read.csv("../data/matchID.csv", stringsAsFactors = F)

# 截取id号
cut.id <- function(x){
  subject.id <- substr(x, 2, 6)
  return(subject.id)
}

# 数据提取
id <- as.numeric(apply(matchID.table, 2, cut.id))
share.id <- intersect(id, notNA.table$subject_id)
