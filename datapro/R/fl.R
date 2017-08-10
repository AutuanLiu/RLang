#####
# Author: @AutuanLiu
# Date: 2017/08/03
#####

# 读入数据
setwd("D:/liuWork/R")
library(readr)
fl <- read_csv("../data/fl.csv")
finfo <- read_csv("../data/file072.csv")
un <- unique(fl)
id <- fl$filename[duplicated(fl)]
sid <- unique(id)

# id 表示有多个csv文件的患者id
ind <- c()
for(i in sid){
  ind <- append(ind, which(fl==i))
}

# 获得多条记录的文件名

fname <- finfo$fileName[ind]
write.csv(fname, "../data/mult.csv")
x <- setdiff(un$filename, sid)
write.csv(as.data.frame(table(id)+1), "../data/id.csv")
write.csv(x, "../data/id1.csv")
io <- setdiff(c(1:1480), ind)
sing.csv <- finfo[io, ]
multi.csv <- finfo[ind, ]
write.csv(sing.csv, "../data/singleTable.csv")
write.csv(multi.csv, "../data/multiTable.csv")

# 信息统计

# 总共有1055个不同的患者，有341个患者具有多个csv文件，共占据了766个csv文件
# 所以，总共还剩余1480-766=714个单个患者的单个csv文件
