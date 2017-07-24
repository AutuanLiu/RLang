# TSclust包的使用
# 通过使用不同的相似度度量和几种聚类算法对合成子序列进行聚类
library(TSclust)
library(cluster)
# 导入数据
data(synthetic.tseries)
# 真实的分类
# AR1,AR2，AR3...
true_cluster <- rep(1:6, each = 3)
# 函数diss（）接受一个数据集和一个指定要使用的TSclust不相似性的字符串
# 返回一个具有所有成对不相似性的dist对象。数据集可以作为mts对象引入，或作为矩阵引入
IP.dis <- diss(synthetic.tseries, "INT.PER")
IP.hclus <- cutree(hclust(IP.dis), k = 6)
# 准确度评估
cluster.evaluation(true_cluster, IP.hclus)
# 使用cluster包的pam算法
IP.pamclus <- pam(IP.dis, k = 6)$clustering
# 准确度评估
cluster.evaluation(true_cluster, IP.pamclus)
# 基于自相关
ACF.dis <- diss(synthetic.tseries, "ACF", p = 0.05)
ACF.hclus <- cutree(hclust(ACF.dis), k = 6)
cluster.evaluation(true_cluster, ACF.hclus)
# pam
ACF.pamclus <- pam(ACF.dis, k = 6)$clustering
cluster.evaluation(true_cluster, ACF.pamclus)
# 基于p值的分层算法
AR.MAH.PVAL.dis <- diss(synthetic.tseries, "AR.MAH")$p_value
AR.MAH.PVAL.clus <- pvalues.clust(AR.MAH.PVAL.dis, significance = 0.05)
cluster.evaluation(true_cluster, AR.MAH.PVAL.clus)
pvalues.clust(AR.MAH.PVAL.dis, significance = 0.6)
LLR.dis <- diss(synthetic.tseries, "SPEC.LLR", method = "LK", n = 500)
LLR.pam <- pam(LLR.dis, k = 6)$clustering
cluster.evaluation(true_cluster, LLR.pam)