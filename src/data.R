top <- matrix(1:12, 3, 4)
top
top <- edit(top)
top
fix(top)
# fix 岂不是更方便啊
top
save(top, file = "E:/s.txt")
s<-load("E:/s.txt")

# paste function
x <- 1:4
y <- c("a", "b", "c", "d")
paste(x, y)
paste(x, y, sep = "-", collapse = "/")

sort(x)
w <- c(2,0,-4,-1,5)
sort(w)
sort(x, decreasing = TRUE)

# plot
y <- 4:8
length(x)<-5
x[5]<-6
plot(x, y)
hist(x)
barplot(x)
plot(x, y, type = "b")
plot(x, y, type = "b", main = "the main title", sub = "the sub title", axes = TRUE)
plot(x, y, type = "b", xlab = "x lable")

matplot(top,type = "b")
pie(x)
