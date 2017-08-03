#!/bin/bash

# author： AutuanLiu
# date： 2017/07/28
# info: based on Ubuntu Kylin 16.04LTS
# 解决忽略掉的csv文件问题

# 如果 statisticsInfo.log 已经存在，那么就先删除，否则，将标准错误信息重定向到
# /dev/null
rm /work/NEstatistics.log 2> /dev/null

# 数据路径设置
shellDir="/home/autuanliu/data/Shell"
storgeDir="/work/neCSV"
csvDir="/work/csv"

# 将满足条件的文件复制到指定目录下
cd $csvDir
for i in $(cat $shellDir/neFile.csv)
    do
        cp ${i}".csv" $storgeDir 2> /dev/null
    done

# 信息统计
cd $storgeDir
du -sh * > ../NEstatistics.log
du -sk * > ../neStaInfo.log

# 执行此脚本的命令： 
# 切到脚本所放位置
# sudo bash ./negativeCP.sh