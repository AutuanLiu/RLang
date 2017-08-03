#####
# Author: @AutuanLiu
# Date: 2017/08/01
#####

# 读入数据
setwd("D:/liuWork/R")
library(readr)
staInfo <- read_csv("../data/finalInfoSta.csv")
mimic2 <- read_csv("../data/MIMIC-II_firsthos_icu_time.csv")
mimic3 <- read_csv("../data/MIMIC-III_carevue_firsthos_icu_time.csv")
