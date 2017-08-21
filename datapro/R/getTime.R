# Date: 2017/08/21
# @Author: AutuanLiu

# 本程序用于获取每位患者发生shock的时间区间
# 并保存为相应的文件
# 相对于记录开始的时间

# 读入数据
setwd("D:/liuWork/R")

# 工作环境clean
rm(list = ls())

# 判断载入包是否存在并安装
if (!require(readr)) {
  install.packages("readr")
}

# shock的发生时间的获取
endresult <- read_csv(
  "../data/endresult_info.csv",
  col_types = list(col_integer(),
                   col_integer(),
                   col_integer(),
                   col_integer())
)

# 文件的长度与记录的开始时间的获取
shockfile <- read_csv(
  "../data/shockfile.csv",
  col_types = list(col_character(),
                   col_integer(),
                   col_integer(),
                   col_integer())
)

# 文件名获取 
temp <- read_csv("../data/temp.csv",
                 col_types = list(col_character()))

# 从shockfile中获取与temp中对应的文件的长度与开始时间的获取
len1 <- dim(temp)[1]
idx <- c()

# 索引的获取
for(file in 1:len1){
  index <- which(shockfile$fileName == temp$file.name[file])
  idx <- append(idx, index)
}

# 文件信息的匹配与截取
shockinfo <- shockfile[idx, ]
appinfo <- endresult[, -1]
shockinterval <- cbind(shockinfo, appinfo)
write.csv(shockinterval, "../data/shockinterval.csv")
shockIDinfo <- cbind(endresult[1], shockinterval[-1])
write.csv(shockIDinfo, "../data/shockIDinfo.csv")



