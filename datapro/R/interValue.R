#####
# Author: @AutuanLiu
# Date: 2017/08/07~09
#####

##### 这是一个工程项目，所以运行此文件前，先运行zeroRate.R和error.R

# 读入数据
setwd("D:/liuWork/R")
require(readr)

# 操作数据备份,其他变量可以清除，以保证全局环境的整洁，可辨识
manip <- aa
rm(list = ls()[-which(ls() == "manip")])

# 路径设置
directory <- "../data/ppcs/"
storeDir <- "../data/pro/mid/"
storeDir1 <- "../data/pro/end/"
files <- list.files(directory)

# 只选择错误率HR和SBP同时小于15%的数据
error.table <-
  read_csv(
    "../data/errorShai.csv",
    col_types = list(
      col_character(),
      col_double(),
      col_double(),
      col_double(),
      col_integer(),
      col_integer()
    )
  )

# 获取HR，SBP的错误索引list

tagT.idx <- which(error.table$tag == 1)
manip <- manip[tagT.idx * 2]

# get index of filename
fn.index <- function(file) {
  x <- which(files == file)
  return(x)
}

# 插值函数(线性插值，5个历史点，前5个若有异常值使用均值插值)
# 为简化程序，小于5的统一使用均值进行插值，可能4时也可以使用线性插值
# 但考虑到时数据的起始部分，所以做近似处理
linerfit <- function(value, pos, minv, maxv){
  # 此处设计一个循环，用于对每个位置进行插值
  for (i in pos) {
    # 构建用于线性拟合的数据集
    x <- c((i - 5):(i - 1))
    y <- value[x]
    lm1 <- lm(y ~ x+1)
    # 拟合系数获取y~a*x+b
    a <- coefficients(lm1)[2]
    b <- coefficients(lm1)[1]
    # 求出预测值并填补
    fitv <- a * i + b
    # 保留一位小数，四舍五入
    ffit <- round(fitv, 1)
    
    # 判断是否符合数值范围
    if(ffit < minv || ffit > maxv){
      # 使用前向插值
      ffit <- value[i-1]
    }
    value[i] <- ffit
  }
  return(value)
}

interValue <- function(value, pos, minv, maxv) {
  # 若最小的位置在前5个，则要单独处理
  if (min(pos) <= 5) {
    less5.idx <- which(pos <= 5)
    # 考虑前向插值，可以尽量避免0的影响
    mvalue <- value[1]
    # 平均值插值
    # mvalue <- mean(value)
    # 本身就是向量操作，这里不考虑循环
    value[pos[less5.idx]] <- mvalue
    pos1 <- pos[-less5.idx]
    value <- linerfit(value, pos1, minv, maxv)
  } else {
    value <- linerfit(value, pos, minv, maxv)
  }
  return(value)
}

# 文件的处理函数
processFile <- function(file) {
  # 读入文件
  csv.in <-
    read_csv(
      paste0(directory, file),
      col_types = list(
        col_character(),
        col_number(),
        col_number(),
        col_number(),
        col_number()
      )
    )
  # 去掉表示单位的那一行
  csv.in <- csv.in[-1,]
  # col rename
  colnames(csv.in) <-
    c("Time", "HR", "ABPSys", "ABPDias", "ABPMean")
  
  # 处理文件，进行插值，SBP第一个非0，最后一个非0，中间数据分别进行处理，窗口设置为5
  # 获取文件的HR，SBP的error.index
  this.idx <- fn.index(file)
  hr.eidx <- manip[this.idx]$info$hr
  sbp.eidx <- manip[this.idx]$info$sbp
  # 文件长度的获取
  lenf <- length(csv.in$Time)
  # 索引全集构造
  full.idx <- c(1:lenf)
  
  # 去掉前面为0的部分
  righr.idx <- setdiff(full.idx, hr.eidx)
  rigsbp.idx <- setdiff(full.idx, sbp.eidx)
  # 两者正确索引的最小值的最大值，前面数据的处理
  start.idx <- max(min(righr.idx), min(rigsbp.idx))
  # 上述计算说明需要去掉 1:(start.idx - 1)行
  
  # 两者正确索引的最大值的最小是，末尾数据的处理
  end.idx <- min(max(righr.idx), max(rigsbp.idx))
  # 如果差值小于等于5个记录点，则取最大值
  if (abs(max(righr.idx) - max(rigsbp.idx)) <= 5) {
    end.idx <- max(max(righr.idx), max(rigsbp.idx))
  }
  # 从end.idx + 1开始都是0
  
  # 总结前后的无效数据索引
  # 先考虑索引超限的问题
  if (start.idx == 1) {
    if (end.idx == lenf) {
      invalid.index <- c() # NULL
    } else {
      # 取后半部分
      invalid.index <- c((end.idx + 1):lenf) 
    }
  } else {
    if (end.idx == lenf) {
      # 取前半部分
      invalid.index <- c(1:(start.idx - 1)) 
    } else {
      # 取两边部分
      invalid.index <- c(1:(start.idx - 1), (end.idx + 1):lenf) 
    }
  }
  
  # 保存中间文件
  # 先考虑无效索引是否为空
  if (is.null(invalid.index)) {
    csv.mid <- csv.in
  } else {
    csv.mid <- csv.in[-invalid.index,]
  }
  
  # 保存文件
  write.csv(csv.mid, paste0(storeDir, file))
  
  # 对中间文件进行线性插值，以5为长度
  # 首先排除掉上面计算过的为0的索引，得到需要插值的索引范围
  range <- c(start.idx:end.idx)
  
  # 需要进行插值的索引,在csv.mid的基础之上
  hr.imputed <- intersect(hr.eidx, range) - start.idx + 1
  sbp.imputed <- intersect(sbp.eidx, range) - start.idx + 1
  
  # 插值实现
  # 获取hr和sbp的值,以csv.mid为基础,暂时只处理hr和sbp的值
  hr.value <- csv.mid$HR
  sbp.value <- csv.mid$ABPSys
  # 考虑到线性拟合时，需要最少5个点，那么如果存在缺失值在2~5个则要单独处理, 使用平均值插值
  
  # 在csv.mid的基础上进行处理
  # 考虑到重复性，这里使用函数
  HRintered <- interValue(hr.value, hr.imputed, 50, 150)
  SBPintered <- interValue(sbp.value, sbp.imputed, 40, 250)
  # 组合
  csv.end <- cbind(HRintered, SBPintered)
  
  # 保存，文件名不变
  write.csv(csv.end, paste0(storeDir1, substr(file, 1, 25), "csv"), col.names = c("HR", "SBP"))
  # 所有结果均已经保存，所以此处不做返回处理
}

# 批处理函数实现
batchExe <- function(files) {
  for (i in files) {
    processFile(i)
  }
}

# 执行函数
batchExe(files)
