#!/bin/bash

# author： AutuanLiu
# date： 2017/08/01
# info: based on Ubuntu Kylin 16.04LTS
# 提取csv文件的2-5列

# 数据路径设置
shellDir="$HOME/data/Shell"
mergeDir="/work/mergeCsv"

# 截取前2-5列，并保存为csv文件
cd $mergeDir
for i in $(cat $shellDir/finalFilename.csv)
    do
        cat $i | awk 'BEGIN {FS=","}{print $1","$2","$3","$4","$5}' > ../getCol4/$i
    done

