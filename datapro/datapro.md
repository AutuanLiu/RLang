# MIMIC waveform 提取
```
author: AutuanLiu
date: 2017/07/15
info: based on Ubuntu Kylin 16.04LTS
```

资料 | 备注
--- | ---
[数据说明][1] | 数据文件命名规则与含义
[软件下载][3] | WFDB package
[操作说明][2] | 自写批处理 `shell` 脚本

## `shell` 脚本文件说明
* extract.sh 文件

extract.sh 脚本用于从 `*.hea` 文件中提取出数据，并存放在`*.csv` 文件中
* match.sh 文件

match.sh 脚本用于从 `*csv` 文件中提取出有 ABP 记录的文件夹名

## 脚本文件下载
* 提取数据

[extract.sh下载][4]

* 匹配数据

[match.sh下载][5]

* 复合代码

[execute.sh下载][6]

> 此代码可以批执行`extract.sh`和`match.sh`，一步到位，并输出最终的结果

> 请保证 3 个 shell 脚本存储在同一个文件夹下。否则，请给对应命令设置存储目录



[1]:https://physionet.org/physiobank/database/mimic2wdb/matched/
[2]:https://physionet.org/faq.shtml
[3]:https://www.physionet.org/physiotools/wfdb.shtml
[4]:http://ooccr4mhp.bkt.clouddn.com/code/shell/extract.sh
[5]:http://ooccr4mhp.bkt.clouddn.com/code/shell/match.sh
[6]:http://ooccr4mhp.bkt.clouddn.com/code/shell/execute.sh