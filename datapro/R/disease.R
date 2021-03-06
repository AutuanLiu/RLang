#####
# Author: @AutuanLiu
# Date: 2017/08/04
#####

#####
# 本程序用于找出发生 sepsis shock 的患者信息
#####

# 读入数据
setwd("D:/liuWork/R")
require(readr)
endfile <- read_csv(
  "../data/endfile.csv",
  col_types = list(
    col_character(),
    col_double(),
    col_double(),
    col_double()
  )
)

shock <- read_csv(
  "../data/endresult_info.csv",
  col_types = list(
    col_integer(),
    col_integer(),
    col_integer(),
    col_integer()
  )
)

subject1 <- as.numeric(substr(endfile$file.name, 2, 6))
subject2 <- shock$id
sharedId1 <- intersect(subject1, subject2)
index <- c()
len <- length(sharedId1)
for(idx in 1:len){
  index <- append(index, which(subject1 == sharedId1[idx]))
}
end.result <- endfile[index, ]
# save result
write.csv(end.result, "../data/endresult.csv")
