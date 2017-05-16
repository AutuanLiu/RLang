# ggplot2 package
library("ggplot2")
img1 <- ggplot(faithful, aes(x = eruptions, y = waiting)) + geom_point() + stat_smooth()
# ggplot() 的调用
img2 <- ggplot(quakes, aes(x = depth)) + geom_bar()
img3 <- ggplot(quakes, aes(x = depth)) + geom_bar(binwidth = 50)

# lattice package
library("lattice")
img4 <- xyplot(mpg ~ hp | factor(cyl), data = mtcars, type = c("p", "r"), 
         main = "Fuel economy vs. Performance",
         xlab = "Performance (horse power)",
         ylab = "Fuel economy (miles per gallon)"
         )
# 添加关于字体调整内容
img5 <- xyplot(mpg ~ hp | factor(cyl), data = mtcars, type = c("p", "r"),
               main = list(
                 label = "Fuel economy vs. Performance given Number of Cylinders",
                 cex = 0.75
                 ),
               xlab = list(
                 label = "Performance (horse power)",
                 cex = 0.75
                 ),
               ylab = list(
                 label = "Fuel economy (miles per gallon)",
                 cex = 0.75
                 ),
               scales = list(cex = 0.5)
               )












