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

# 箱线图
img6 <- bwplot(~ hp | factor(cyl), data = mtcars, main = "bwplot example")
# barchart example
img7 <- barchart(yield ~ variety | site, data = barley,
                 groups = year, layout = c(1,6), stack = TRUE,
                 auto.key = list(space = "right"),
                 ylab = "Barley Yield (bushels/acre)",
                 scales = list(x = list(rot = 45))
)
## Grouped dot plot showing anomaly at Morris

img8 <- dotplot(variety ~ yield | site, data = barley, groups = year,
                key = simpleKey(levels(barley$year), space = "right"),
                xlab = "Barley Yield (bushels/acre) ",
                aspect=0.5, layout = c(1,6) 
)

# ISwR package
library("ISwR")
img9 <- plot(rnorm(1000))
# 矩阵
x <- 1:12
dim(x) <- c(3, 4)
print(x)
y <- matrix(1:12, nrow = 3)  # 按列填充
z <- matrix(1:12, nrow = 3, byrow = T)  # 按行填充
# 数据框
d <- data.frame(intake$pre, intake$post)
# list
mylist <- list(before = intake$pre, after = intake$post)
str(mylist)
# loop
m <- matrix(rnorm(12), 4)
minvalue <- apply(m, 2, min)
# sort
sdata <- sort(intake$pre)
index <- order(intake$pre)
sorder <- intake$pre[index]
intak <- intake[index, ]
