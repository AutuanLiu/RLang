#####
# Author: @AutuanLiu
# Date: 2017/08/01
#####

# 读入数据
setwd("D:/liuWork/R")
library(readr)
directory <- "../data/getCol4/"
files <- list.files(directory)
data <- lapply(files, function(file) {
  read_csv(paste0(directory, file))
  })

data_cbind <- Reduce(cbind, data)



