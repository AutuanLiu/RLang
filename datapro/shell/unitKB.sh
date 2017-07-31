#!/bin/bash

# author： AutuanLiu
# date： 2017/07/15
# info: based on Ubuntu Kylin 16.04LTS
# result： 结果文件存储在～/result/statisticsInfo1.log 文件

# 数据路径设置
dataDir="/work/resCSV"
cd $dataDir

# 如果 statisticsInfo1.log 已经存在，那么就先删除，否则，将标准错误信息重定向到
# /dev/null
rm ../statisticsInfo1.log 2> /dev/null

# 为便于后续操作，将文件大小的单位统一设置为 KB
du -sk * > ../statisticsInfo1.log

# 执行此脚本的命令： 
# 切到脚本所放位置
# sudo bash ./unitKB.sh