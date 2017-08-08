#####
# Author: @AutuanLiu
# Date: 2017/08/04
#####

# 读入数据
setwd("D:/liuWork/R")
library(readr)
directory <- "../data/tpcs/"
files <- list.files(directory)

# 连续8小时数据的判断函数，若存在返回连续的起点，否则返回-1，可能有多个，所以使用向量保存
isContinue <- function(value){
  flag = c() # 保存结果
  value1 <- c(value[-1], 0)
  isExist <- which((value1 - value) > 408) # 8*60
  len <- length(isExist)
  if(len == 0){
    flag <- append(flag, -1)
  } else {
    flag <- append(flag, isExist)
  }
  return(flag)
}

# 求0值，NA，异常值的索引集合
# minv，maxv 分别为异常值得最小值与最大值
getInfo <- function(value, minv, maxv){
  zero.index <- which(value == 0) # 0 值索引
  miss.index <- which(is.na(value)) # 缺失值索引
  abnormal.index <- which(!(value >= minv & value <= maxv & !is.na(value))) # 异常值索引
  # 三者之间存在交叉，所以取他们的交集
  # error.index <- Reduce(intersect, list(zero.index, miss.index, abnormal.index))
  # 由于很可能存在空集，造成错误，所以采用以下方法解决
  error.index <- c()
  error.index <- unique(append(error.index, c(zero.index, miss.index, abnormal.index)))
  zero.rate <- length(error.index)/length(value)
  continuity <- isContinue(value)
  return(list(error.index = error.index, zero.rate = zero.rate, continuity = continuity))
}

# 文件的处理函数
processFile <- function(file){
  # 读入文件
  csv.in <- read_csv(paste0(directory, file), col_types = list(col_character(), 
                                                               col_number(), 
                                                               col_number(), 
                                                               col_number(), 
                                                               col_number()
                                                               )
                     )
  # 去掉表示单位的那一行
  csv.in <- csv.in[-1, ]
  # col rename
  colnames(csv.in) <- c("Time", "HR", "ABPSys", "ABPDias", "ABPMean")
  # 计算变量 "HR", "ABPSys", "ABPDias", "ABPMean" 的0占比
  HR.info <- getInfo(csv.in$HR, 50, 150)
  ABPSys.info <- getInfo(csv.in$ABPSys, 40, 250)
  # ABPDias.info <- getInfo(csv.in$ABPDias)
  ABPMean.info <- getInfo(csv.in$ABPMean, 70, 105)
  # 这里返回的结果，暂时不需要error.index，但是后续的插值需要，所以一同返回
  return(list(info = list(fileName = file, HR = HR.info, ABPS = ABPSys.info, ABPM = ABPMean.info)))
}

# 文件的批处理函数
result <- list() # save result
batchFile <- function(files.list){
  for(fileName in files.list){
    result <- append(result, processFile(fileName))
  }
  return(result)
}

# 调用函数获得最终结果
# 返回的是一个综合的结果
result <- batchFile(files)

# 结果提取与保存
len <- length(result)
final <- c()
for(i in 1:len){
  xx <- cbind(result[i]$info$fileName, result[i]$info$HR$zero.rate, 
          result[i]$info$ABPS$zero.rate, result[i]$info$ABPM$zero.rate)
  final <- append(final, xx)
}

# table 的构建
attr <- 4 # 属性的数量
len1 <- length(final)
file.name <- final[seq(1, len1, attr)]
HR.rate <- final[seq(2, len1, attr)]
ABPS.rate <- final[seq(3, len1, attr)]
ABPM.rate <- final[seq(4, len1, attr)]

combination <- cbind(file.name, HR.rate, ABPS.rate, ABPM.rate)
qq.res <- as.data.frame(combination)

# 保存为文件
write.csv(qq.res, "../data/qqRes.csv")






