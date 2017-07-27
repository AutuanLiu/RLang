# 逻辑回归
no.yes  <- c("yes", "no")
smoking <- gl(2, 1, 8, no.yes)
obesity <- gl(2, 2, 8, no.yes)
snoring <- gl(2, 4, 8, no.yes)
n.tot   <- c(60, 17, 8, 2, 187, 85, 51, 23)
n.hyp   <- c(5, 2, 1, 0, 35, 13, 15, 8)
dfr     <- data.frame(smoking, obesity, snoring, n.tot, n.hyp)
print(dfr)

# expand.grid also do this
exg <- expand.grid(smoking = no.yes, obesity = no.yes, snoring = no.yes)
print(exg)
hyp.tbl <- cbind(n.hyp, n.tot - n.hyp)
print(hyp.tbl)