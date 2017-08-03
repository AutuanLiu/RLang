#!/bin/bash

# author： AutuanLiu
# date： 2017/08/03
# info: based on Ubuntu Kylin 16.04LTS

# 数据路径设置
shellDir="/home/autuanliu/data/Shell"
storgeDir="/work/multTable"
csvDir="/work/single"

# 将满足条件的文件复制到指定目录下
cd $csvDir
for i in $(cat $shellDir/multTable.csv)
    do
       mv $i $storgeDir  2> /dev/null
    done
