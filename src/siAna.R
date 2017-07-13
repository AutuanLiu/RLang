# 使用
# SI~SBP
# library(MSwM)
# sisbp <- read.csv("/home/autuanliu/文档/My301Work/data/test/SISBP.csv")
# plot(ts(sisbp))
# mod <- lm(SI~SBP, data = sisbp)
# mod1 <- msmFit(mod, k = 2, p = 1, sw = c(T, T, T, T), control = list(parallel = F))
# plotProb(mod1, which = 1)
# # plotProb(mod1, which = 2)
# # splot(mod1)

# SI~HR
library(MSwM)
sihr <- read.csv("/home/autuanliu/文档/My301Work/data/test/SIHR.csv")
plot(ts(sihr))
mod2 <- lm(SI~HR, data = sihr)
mod3 <- msmFit(mod2, k = 2, p = 1, sw = c(T, T, T, T), control = list(parallel = F))
plotProb(mod3, which = 2)
# plotProb(mod3, which = 2)
# plot(mod3)

