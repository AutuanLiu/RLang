
files <- "s00151-2509-04-12-15-19n.hea.csv"
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
this.idx <- fn.index(files)
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
# 如果差值小于等于5个记录点，则取最大值
if(abs(max(righr.idx) - max(rigsbp.idx)) <= 5){
  end.idx <- max(max(righr.idx), max(rigsbp.idx))
}
# 从end.idx + 1开始都是0

# 总结前后的无效数据索引
invalid.index <- c(1:(start.idx-1), (end.idx+1):filel[this.idx])

# 保存中间文件
csv.mid <- csv.in[-invalid.index, ]
range <- c(start.idx:end.idx)
hr.imputed <- intersect(hr.eidx, range) - start.idx + 1
sbp.imputed <- intersect(sbp.eidx, range) - start.idx + 1

# 插值实现
# 获取hr和sbp的值,以csv.mid为基础,暂时只处理hr和sbp的值
hr.value <- csv.mid$HR
sbp.value <- csv.mid$ABPSys
# 考虑到线性拟合时，需要最少5个点，那么如果存在缺失值在2~5个则要单独处理, 使用平均值插值
# 在csv.mid的基础上进行处理
# 考虑到重复性，这里使用函数
HRintered.value <- interValue(value = hr.value, pos = hr.imputed)
SBPintered.value <- interValue(value = sbp.value, pos = sbp.imputed)
# 组合
csv.end <- cbind(HRintered.value, SBPintered.value)
