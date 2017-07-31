#!/bin/bash

# author： AutuanLiu
# date： 2017/07/15
# info: based on Ubuntu Kylin 16.04LTS
# 解决忽略掉的csv文件问题

# 数据路径设置
shellDir="/home/autuanliu/data/Shell"
storgeDir="/work/necsv1"

# 将满足条件的文件复制到指定目录下
cd $storgeDir
for i in $(cat $shellDir/neCutDir.csv)
    do
        x=`ls | grep $i`
        rm $x
    done

# 执行此脚本的命令： 
# 切到脚本所放位置
# sudo bash ./mergeSimple.sh