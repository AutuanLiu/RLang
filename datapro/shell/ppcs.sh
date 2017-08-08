#!/bin/bash

# author： AutuanLiu
# date： 2017/08/08
# info: based on Ubuntu Kylin 16.04LTS

# 数据路径设置
shellDir="/home/autuanliu/data/Shell"
storgeDir="/work/ppcs"
csvDir="/work/final"

# 将满足条件的文件复制到指定目录下
cd $csvDir
for i in $(cat $shellDir/ppcs.csv)
    do
       cp $i $storgeDir  2> /dev/null
    done
