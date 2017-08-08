#####
# Author: @AutuanLiu
# Date: 2017/08/07
#####

# 这是一个工程项目，所以运行此文件前，先运行zeroRate.R和error.R


# 读入数据
setwd("D:/liuWork/R")
directory <- "../data/ppcs/"
files <- list.files(directory)
                    
# 操作数据备份,其他变量可以清除，以保证全局环境的整洁，可辨识
manip <- aa
# rm(list = ls()[-which(ls() == "manip")])

# 只选择错误率HR和SBP同时小于15%的数据
error.table <- readr::read_csv("../data/errorShai.csv")
tagT.idx <- which(error.table$tag == 1)
manip <- manip[tagT.idx*2]
filel <- error.table$fileLength[tagT.idx]

# files <- "s00151-2509-04-12-15-19n.hea.csv"

# get index of filename
fn.index <- function(file){
  return(which(files == file))
}

# 文件的处理函数
processFile <- function(file){
  # 读入文件
  csv.in <- readr::read_csv(paste0(directory, files), col_types = list(col_character(), 
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
  
  # 处理文件，进行插值，SBP第一个非0，最后一个非0，中间数据分别进行处理，窗口设置为5
  # 获取改文件的HR，SBP的error.index
  this.idx <- fn.index(file)
  hr.eidx <- manip[this.idx]$info$hr
  sbp.eidx <- manip[this.idx]$info$sbp
  full.idx <- c(1:filel[this.idx])
  # 去掉前面为0的部分
  rigsbp.idx <- setdiff(full.idx, sbp.eidx)
  righr.idx <- setdiff(full.idx, hr.eidx)
  # 两者正确索引的最小值的最大值，前面数据的处理
  start.idx <- max(min(righr.idx), min(rigsbp.idx))
  # 上述计算说明需要去掉 1:(start.idx - 1)行
  # 两者正确索引的最大值的最小是，末尾数据的处理
  end.idx <- min(max(righr.idx), max(rigsbp.idx))
}




