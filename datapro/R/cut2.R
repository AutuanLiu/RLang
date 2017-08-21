#####
# Author: @AutuanLiu
# Date: 2017/08/01
#####

###
# 2674的基础上对文件进行截取
###

# 去掉不满足条件的id
setwd("D:/liuWork/R")
com.table <- read.csv("../data/difTime1.csv", stringsAsFactors = F)
fileNeed <- com.table[com.table$deltaTime < 0, 1]
# 去掉含有NA值的行
na.index <- idx(com.table$deltaTime)
com.table1 <- com.table[-na.index, ]


# 保存数据
write.csv(com.table1, "../data/notNA1.csv")

