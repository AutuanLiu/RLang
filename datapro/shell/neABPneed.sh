#!/bin/bash

# author： AutuanLiu
# date： 2017/07/31
# info: based on Ubuntu Kylin 16.04LTS

# 数据路径设置
shellDir="/home/autuanliu/data/Shell"
storgeDir="/work/neABPneed"
necsvDir="/work/neCSV"

# 将满足条件的文件复制到指定目录下
cd $necsvDir
for i in $(cat $shellDir/neABPneed.csv)
    do
        cp $i $storgeDir 2> /dev/null
    done

# 执行此脚本的命令： 
# 切到脚本所放位置
# sudo bash ./neABPneed.sh