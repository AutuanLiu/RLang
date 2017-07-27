#####
# Author: @AutuanLiu
# Date: 2017/07/26
#####

# 实现数据的处理和提取
setwd("D:/liuWork/R")
mimic2 <- read.csv("../data/MIMIC-II_firsthos_icu_time.csv", stringsAsFactors = F)
mimic3 <- read.csv("../data/MIMIC-III_carevue_firsthos_icu_time.csv", stringsAsFactors = F)
fileName <- read.csv("../data/filename.csv", header = F, stringsAsFactors = F)

# 数据提取
id <- apply(fileName, 2, cut.id)
rTime <- apply(fileName, 2, cut.time)

# 构造新格式的数据框
new.info <- cbind(as.numeric(id), rTime)
# 增加列名称
colnames(new.info) <- c("subject_id", "record_time")

# 获取时间差
dif.time <- function(record.time, icu.inTime){
  dif <- difftime(strptime(record.time, "%Y-%m-%d-%H-%M"),
                  strptime(icu.inTime, "%Y/%m/%d %H:%M:%S"), units = "mins")
  return(as.numeric(dif))
}

# 获取索引
index <- function(x){
  for(i in 1:length(mimic2$subject_id)){
    if(mimic2$subject_id[i] == x){
      ind <- i
    }
  }
  return(ind)
}

# 存储时间差
len <- length(new.info[, 1])
deltaTime <- rep(NA, len)
for(i in 1:len){
  if(new.info[i, 1] %in% mimic2$subject_id){
    ind <- index(as.integer(new.info[i, 1]))
    deltaTime[i] <- dif.time(new.info[i, 2], mimic2$icustay_intime[ind])
  }
}

# 得到最终的完整csv文件并保存
new.table <- cbind(new.info, deltaTime)
write.csv(new.table, file = "../data/difTime.csv", fileEncoding = "UTF-8")


