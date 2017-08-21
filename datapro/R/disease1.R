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
  "../data/septic_shock_subset.csv",
  col_types = list(
    col_integer(),
    col_integer()
  )
)

subject1 <- as.numeric(substr(endfile$file.name, 2, 6))
subject2 <- shock$id
sharedId <- intersect(subject1, subject2)
diff <- setdiff(sharedId, sharedId1)
print("the diff id is: ")
print(diff)

write.csv(sharedId, "../data/endresult.csv")
