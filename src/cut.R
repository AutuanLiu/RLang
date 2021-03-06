#####
# Author: @AutuanLiu
# Date: 2017/07/26
#####

# 去掉不满足条件的id
setwd("D:/liuWork/R")
com.table <- read.csv("../data/difTime.csv", stringsAsFactors = F)
com.table$deltaTime[com.table$deltaTime < 0] <- NA

# 获得NA索引
idx <- function(x){
  index <- c()
  for(i in 1:length(x)){
    if(is.na(x[i])){
      index <- append(index, i)
    }
  }
  return(index)
}

# 去掉含有NA值的行
na.index <- idx(com.table$deltaTime)
com.table <- com.table[-na.index, ]

# 保存数据
write.csv(com.table, "../data/notNA.csv")


