library("ISwR")

# 回归诊断
attach(cystfibr)
lm.velo <- lm(pemax ~ height + I(height^2))
opar <- par(mfrow = c(2,2), mex = 0.6, mar = c(4,4,3,2) + .3)
plot(rstandard(lm.velo))
plot(rstudent(lm.velo))
plot(dffits(lm.velo), type = "l")
matplot(dfbetas(lm.velo), type = "l", col = "black")
lines(sqrt(cooks.distance(lm.velo)), lwd = 2)
par(opar)

