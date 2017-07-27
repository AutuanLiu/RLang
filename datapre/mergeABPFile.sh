#!/bin/bash

# author： AutuanLiu
# date： 2017/07/15
# info: based on Ubuntu Kylin 16.04LTS
# result： 结果文件存储在～/result/resultABP 文件夹下
# statisticsInfo: 统计信息保存在 ～/result 文件夹下

# 如果 statisticsInfo.log 已经存在，那么就先删除，否则，将标准错误信息重定向到
# /dev/null
rm ~/result/statisticsInfo.log 2> /dev/null

# 数据路径设置
dataDir="/home/autuanliu/data/MIMICII-submatched-numeric"
shellDir="/home/autuanliu/data/Shell"
storgeDir="/home/autuanliu/result/resultABP/"
cd $dataDir

# 将满足条件的文件复制到指定目录下
for i in $(cat $shellDir/dirNameNeed.log)
    do
        cd $i
        cp *.csv ~/result/resultABP
        # 这里做了一点无用功，比较耗时，如果要精确匹配，比较耗费人力
        # 以时间换精力
        for j in $(cat $shellDir/needABP.log)
            do
                cp $j ~/result/resultABP 2> /dev/null
            done
        cd ../
    done

# 信息统计
cd $storgeDir
du -sh * > ~/result/statisticsInfo.log

# 执行此脚本的命令： 
# 切到脚本所放位置
# sudo bash ./mergeABPFile.sh