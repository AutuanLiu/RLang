#####
# Author: @AutuanLiu
# Date: 2017/07/29
#####

# 去掉没有ABP的负值csv
setwd("D:/liuWork/R")
dir.table <- read.csv("../data/dirNameNeed.csv", header = F, stringsAsFactors = F)
necsv.table <- read.csv("../data/neCSVName.csv", header = F, stringsAsFactors = F)

# 唯一值
dir.table <- unique(dir.table)
ne.dird <- apply(necsv.table, 2, getDirName)
ne.dir <- unique(ne.dird)

# 取既是负的又含有ABP的id
shared.dir <- intersect(dir.table[, 1], ne.dir)

# 要去掉的id
cut.dir <- setdiff(ne.dir, shared.dir)
write.csv(cut.dir, "../data/neCutDir.csv")

# 统计个数
count <- 0
for(i in shared.dir){
  for(j in ne.dird){
    if(i == j){
      count <- count + 1
    } 
  }
}

x <- paste("既是负值且ID下含有ABP的文件共有", count, "个")
print(x)

# 剩余部分还有可能有的是没有ABP的
