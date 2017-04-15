# env
demo <- function(a, b, c, d){
  print(objects())
}
y <- demo(1, "ddd", list(c(1:3)), 3:4)
y[1]

g <- function(x, y = 10) {
  x + y
}
g(1)
g(2, 4)

# ...
v <- c(sqrt(1:100))
f <- function(x, ...) {
  print(x);
  summary(...)
}

f("here is the summary for v.", v, digits = 2)

add <- function(x, ...) {
  args <- list(...) 
  # 将所有参数转化为一个list
  for (a in args) {
    x <- x + a;
  }
  x # return x
  # print the result
}

# 实现对变长参数的调用
add(1, 1, 2)
add(2, 3, 4, 1, 8, 9)

fs <- function(x) {
  return (x^2 + 3)
}

fs(3)

a <- 1:7
sapply(a, sqrt)
sqrt(a)

# 匿名函数
apply <- function(f) {
  f(3)
}

apply(function(x) {
  x * 7
})

sapply(a, function(x) {
  x + 1
})

# slice to calculate
v <- 1:20
w <- NULL
for (i in 1:length(v)) {
  w[i] <- v[i]^2
}
v;w

# example to up
w <- NULL
w <- sapply(v, function(i) {
  i^2
})
# sapply 起到了打散每一个向量中的元素的目的

(function(x) {
  x + 1
})(3)
# 函数体必须使用括号包含起来
args(lm)



















