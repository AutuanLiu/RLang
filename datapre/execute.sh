#!/bin/bash

# author： AutuanLiu
# date： 2017/07/15
# info: based on Ubuntu Kylin 16.04LTS

# shell 脚本存储路径设置
# 请保证 3 个 shell 脚本存储在同一个文件夹下
# 否则，请给对应命令设置存储目录
dataDir="$HOME/文档/RWork/"
cd $dataDir

# 执行数据的提取工作
bash ./extract.sh

# 执行数据的匹配工作
bash ./match.sh

# 结果处理
# .csv 格式
echo ""
echo "提取出的数据保存在原数据对应的目录下，并以对应的 hea_name.hea.csv 命名"
echo ""
echo "所匹配到的数据如所打开的窗口所示: "

# 查看最终的匹配文件
# 请替换为你已安装的文本查看器命令
# 或者选择以下的命令之一
# vim ~/matchID.csv 2> /etc/null
# gedit ~/matchID.csv 2> /etc/null
pluma ~/matchID.csv 2> /etc/null

# 当匹配项较少时，也可以使用以下命令 
# cat ~/matchID.csv

# 执行此脚本的命令： 
# 切到脚本所放位置
# sudo bash ./execute.sh

# Tips: 此代码是一步到位的，想要获得单独的功能，请参看或使用 extract.sh 和 match.sh