
bb <- difftime(strptime("2896-10-09-01-56", "%Y-%m-%d-%H-%M")
               ,strptime("2896-10-10-05-56", "%Y-%m-%d-%H-%M"),units = "mins")

cc <- abs(as.numeric(bb))/60

