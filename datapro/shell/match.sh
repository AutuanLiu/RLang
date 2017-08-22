#!/bin/bash

# author： AutuanLiu
# date： 2017/07/15
# info: based on Ubuntu Kylin 16.04LTS
# result： 结果文件存储在～/下的matchID.csv文件中

# 用于匹配表头含有ABPMean的患者ID和文件名

# 如果matchID.csv和matchABP.csv已经存在，那么就先删除，否则，将标准错误信息重定向到
# /dev/null
# 因为采用文件追加的方法，所以在每次执行时，必须删除之前的结果
rm ~/matchID.csv 2> /dev/null
rm ~/matchABP.csv 2> /dev/null

# 数据路径设置
dataDir="/home/autuanliu/data/MIMICII-submatched-numeric"
cd $dataDir

# 为了简化代码，将log文件默认存储在～/下（家目录）
# ~/即 /home/usr_name/也即 $HOME 的值
ls > ~/dir1.log

# 为便于对应：输出文件默认为相应的hea文件名，加上.csv后缀
for i in $(cat ~/dir1.log)
    do
        cd $i
        ls *.csv > ~/csv.log 
        for j in $(cat ~/csv.log)
            do
                # 提取表格的第一行，即表头信息
                sed -n '1p' $j > ~/heading.log
                # 这里涉及一个模式匹配
                if cat ~/heading.log | grep "ABPMean" > /dev/null
                    then
                        # 将满足条件的文件名，以追加的方法重定向到matchABP.csv文件 
                        echo $i >> ~/matchID.csv
                        echo $j >> ~/matchABP.csv
                else
                        continue
                fi
            done
        cd ../
    done

# 由于每个文件夹下可能有多个表，所以必须去除重复信息（重复信息是相邻的）
cat ~/matchID.csv | uniq > ~/matchID1.csv

# 删除中间文件
cd ~
sudo rm dir1.log csv.log heading.log matchID.csv

# 执行此脚本的命令： 
# 切到脚本所放位置
# sudo bash ./match.sh

# Tips: shell编程能力有限，主要注重功能。细节部分，或者逻辑可能有潜在问题
