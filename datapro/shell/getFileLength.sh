#!/bin/bash

# author： AutuanLiu
# date： 2017/08/01
# info: based on Ubuntu Kylin 16.04LTS

# 由于采用追加的方式，所以运行前必须删除之前的文件
rm /work/csvLength.csv

# 数据路径设置
shellDir="$HOME/data/Shell"
heaDir="/work/hea"

# 将信息保存在/work目录下
cd $heaDir
for i in $(cat $shellDir/finalHeaFile.csv)
    do
        length=`sed -n '1p' $i | awk '{print $4}'`
        echo ${i}".csv,$length" >> ../csvLength.csv
    done
