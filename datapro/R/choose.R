#####
# Author: @AutuanLiu
# Date: 2017/08/03
#####

# 读入数据
setwd("D:/liuWork/R")
library(readr)
sing <- read_csv("../data/singleTable.csv")
dd <- sing$`deltaTime(M)`
dd[sing$`deltaTime(M)` < 0] <- 0
xx <- (sing$tag1 == 1) & (sing$`deltaTime1(M)` - dd >= 60*8) & sing$`deltaTime1(M)` >= 24*60
yy <- sing[xx, ]
tt <- yy[yy$`deltaTime(M)` < 16*60, ]
write.csv(tt, "../data/tp1.csv")

# 多表处理
# sing <- read_csv("../data/multiTable.csv")
# dd <- sing$`deltaTime(M)`
# dd[sing$`deltaTime(M)` < 0] <- 0
# xx <- (sing$tag1 == 1) & (sing$`deltaTime1(M)` - dd >= 60*8) & sing$`deltaTime1(M)` >= 24*60
# yy <- sing[xx, ]
# 
# tt <- yy[yy$`deltaTime(M)` < 16*60, ]
# write.csv(tt, "../data/tp2.csv")