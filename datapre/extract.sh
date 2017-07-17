#!/bin/bash

# author： AutuanLiu
# date： 2017/07/15
# info: based on Ubuntu Kylin 16.04LTS
# result：结果保存在与数据对应的文件夹下

# 数据路径设置
dataDir="$HOME/文档/My301Work/data/mimic/"
cd $dataDir

# 为了简化代码，将log文件默认存储在～/下（家目录）
# ~/即 /home/usr_name/也即 $HOME 的值
ls > ~/dir.log

# 为便于对应：输出文件默认为相应的hea文件名，加上.csv后缀
for i in $(cat ~/dir.log)
    do
        cd $i
        ls *.hea > ~/head.log
        for j in $(cat ~/head.log)
            do
                rdsamp -r $j -pe -pd  -v -c > ${j}.csv
            done
        cd ../
    done

# 删除中间文件
cd ~
sudo rm dir.log head.log

# 执行此脚本的命令： 
# 切到脚本所放位置
# sudo bash ./extract.sh

# Tips: shell编程能力有限，主要注重功能。细节部分，或者逻辑可能有潜在问题
