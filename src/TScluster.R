# TSclust包的使用
library(TSclust)
library(cluster)
data(synthetic.tseries)
true_cluster <- rep(1:6, each = 3)
IP.dis <- diss(synthetic.tseries, "INT.PER")
IP.hclus <- cutree(hclust(IP.dis), k = 6)
cluster.evaluation(true_cluster, IP.hclus)
IP.pamclus <- pam(IP.dis, k = 6)$clustering
cluster.evaluation(true_cluster, IP.pamclus)
ACF.dis <- diss(synthetic.tseries, "ACF", p = 0.05)
ACF.hclus <- cutree(hclust(ACF.dis), k = 6)
cluster.evaluation(true_cluster, ACF.hclus)
ACF.pamclus <- pam(ACF.dis, k = 6)$clustering
cluster.evaluation(true_cluster, ACF.pamclus)
AR.MAH.PVAL.dis <- diss(synthetic.tseries, "AR.MAH")$p_value
AR.MAH.PVAL.clus <- pvalues.clust(AR.MAH.PVAL.dis, significance = 0.05)
cluster.evaluation(true_cluster, AR.MAH.PVAL.clus)
pvalues.clust(AR.MAH.PVAL.dis, significance = 0.6)
LLR.dis <- diss(synthetic.tseries, "SPEC.LLR", method = "LK", n = 500)
LLR.pam <- pam(LLR.dis, k = 6)$clustering
cluster.evaluation(true_cluster, LLR.pam)