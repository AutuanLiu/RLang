#!/bin/bash

# author： AutuanLiu
# date： 2017/07/15
# info: based on Ubuntu Kylin 16.04LTS
# result： 结果文件存储在～/result/resultABP 文件夹下
# statisticsInfo: 统计信息保存在 ～/result 文件夹下

# 如果 statisticsInfo.log 已经存在，那么就先删除，否则，将标准错误信息重定向到
# /dev/null
rm /work/statisticsInfo.log 2> /dev/null

# 数据路径设置
shellDir="$HOME/data/Shell"
storgeDir="/work/resCSV"
csvDir="/work/csv"

# 将满足条件的文件复制到指定目录下
cd $csvDir
for i in $(cat $shellDir/needABP.log)
    do
        cp $i $storgeDir 2> /dev/null
    done

# 信息统计
cd $storgeDir
du -sh * > ../statisticsInfo.log

# 执行此脚本的命令： 
# 切到脚本所放位置
# sudo bash ./mergeSimple.sh