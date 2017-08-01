#!/bin/bash

# author： AutuanLiu
# date： 2017/08/01
# info: based on Ubuntu Kylin 16.04LTS

# 由于采用追加的方式，所以运行前必须删除之前的文件
rm /work/StartendTime.csv

# 数据路径设置
shellDir="$HOME/data/Shell"
csvDir="/work/csv"

# 将信息保存在/work目录下
cd $csvDir
for i in $(cat $shellDir/finalFilename.csv)
    do
        startTime=`sed -n '3p' $i | awk 'BEGIN {FS=","}{print $1}'`
        endTime=`sed -n '$p' $i | awk 'BEGIN {FS=","}{print $1}'`
        echo ${i}",$startTime,$endTime" >> ../StartendTime.csv
    done
