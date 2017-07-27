#####
# Author: @AutuanLiu
# Date: 2017/07/27
#####

# 获得目录名
getDirName <- function(x){
  dir.name <- substr(x, 1, 6)
  return(dir.name)
}

# 截取id号
cut.id <- function(x){
  subject.id <- substr(x, 2, 6)
  return(subject.id)
}

# 截取开始记录的时间
cut.time <- function(x){
  record.time <- substr(x, 8, 23)
  return(record.time)
}

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

# 获得含有ABP记录的文件的索引
getIndex <- function(x, y){
  len <- length(x)
  index <- c()
  for(i in 1:len){
    index <- append(index, as.numeric(which(y == x[i])))
  }
  return(index)
}
