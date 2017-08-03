#!/bin/bash

# author： AutuanLiu
# date： 2017/08/01
# info: based on Ubuntu Kylin 16.04LTS

# 数据路径设置
dataDir="$HOME/data/MIMICII-submatched-numeric"
cd $dataDir

ls > ~/dir.log

# copy
for i in $(cat ~/dir.log)
    do
        cd $i
        cp *.hea /work/hea
        cd ../
    done

# 删除中间文件
cd ~
sudo rm dir.log
