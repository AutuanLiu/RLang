```
author: AutuanLiu
date: 2017/07/15
info: based on Ubuntu Kylin 16.04LTS
```
**此文档为归类总结文档，具体说明代码是干什么用的**

* 关于从 MIMIC 的原始数据中提取出csv文件的方法，请参看 `datapro.md`

## Shell 文件说明

* 路径 ./shell/

* 代码信息表

notes: 关于代码的具体信息参看代码的行内注释，PPT等

id | 文件名 | 说明 | 备注
--- | --- | --- | ---
1 | extract.sh |用于从 MIMIC 的原始数据中提取出可读写的csv文件 | 保存在各自的文件夹下
2 | match.sh | 用于匹配表头含有ABPMean的患者ID和文件名 | 
3 | execute.sh | 解析并匹配文件，是1,2的结合 | 可以单独执行
4 | extractMerge.sh | 1 的升级版本 | 所有的csv文件整合在一个文件夹下
5 | getCol4.sh | 提取csv文件的2~5列 |
6 | finalABPFile.sh | 将满足条件的文件复制到指定目录下 | 根据文件名列表进行复制，移动，多次用到
7 | finalPO.sh | 根据fileneed.csv进行复制 | 这样的csv文件大多由R计算得到，6 改编
8 | getFileLength.sh | 获取文件的长度 | 从hea文件提取
9 | getSEtime.sh | 每条记录的开始时间与结束时间的获取 | 
10 | heaExtract.sh | 将文件夹下的所有.hea文件复制到同一文件夹下 | 为了方便操作
11 | mergeSimple.sh | 根据needABP.log进行文件的筛选并**统计文件的信息** | needABP.log由R构建  
12 | multMV.sh | 将某患者含有多个文件的单独保存 | 主要目的是实现文件的分类保存
13 | ne*.sh | 这部分代码已经无效 | 中间走的弯路写的代码
14 | ppcs.sh | 根据ppcs.csv进行文件的筛选 | csv文件由R构建
15 | tpcs.sh | 根据tpcs.csv进行文件的筛选 | csv文件由R构建
16 | shock.sh | 根据endresultfile.csv进行文件的筛选 | csv文件由R构建
17 | unitKB.sh | 将文件的统计信息以KB的单位统计 |

** 大部分代码中需要使用的csv文件都由R构造，详情参看R的代码

## R 文件说明

* 路径 ./R/

* 代码信息表

id | 文件名 | 说明 | 备注
--- | --- | --- | ---
1 | dataPro.R | 数据处理 |
2 | error.R | 0索引的计算
3 | interValue.R | 插值的实现
4 | zeroRate.R | 0占比的计算
5 | function.R | 函数的定义

## Matlab 文件说明

* 路径 ./matlab

* 信息表

id | 文件名 | 说明 | 备注
--- | --- | --- | ---
1 | batch2data.m | 用于批量读取某目录下的文件内容并保存为mat数据 | 数据批量获取的关键步骤
2 | plotimg.m | 主要用于数据可视化 |



## data文件说明

* 路径 ./data

这部分的数据大部分为统计信息或者shell代码中需要的输入文件，大部分由R创造
