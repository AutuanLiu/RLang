#####
# Author: @AutuanLiu
# Date: 2017/08/08
#####

# 这是一个工程项目，所以运行此文件前，先运行zeroRate.R
# 读入数据
setwd("D:/liuWork/R")

# 操作数据备份,其他变量可以清除，以保证全局环境的整洁，可辨识
resultb <- result
rm(list = ls()[-which(ls() == "resultb")])

# error index 处理
len2 <- length(resultb)
aa <- list()
for(i in 1:len2){
  fileName <- resultb[i]$info$fileName
  hr <- resultb[i]$info$HR$error.index
  sbp <- resultb[i]$info$ABPS$error.index
  if(length(hr) == 0) hr <- 0
  if(length(sbp) == 0) sbp <- 0
  rebind <- list(filename = fileName, info = list(hr = hr, sbp = sbp))
  # write.csv(rebind, "../data/def.csv", append = T)
  aa <- append(aa, rebind)
}

# 每列的长度不确定，所以不大好组合，而且他们的数据类型是不一样的