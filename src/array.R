# array
a <- array(c(101:124), c(2, 3, 4))
# 查看类型
class(a[1, 1, ])
# 矩阵赋值
m[1:2, 1:2] = matrix(c(1001:1004), 2, 2)
m[1:2, 1:2]
m
# 元素本身得到了修改
x <- rep(c(TRUE, FALSE), 10)
v[x]
v[(v %% 3 == 0)]

# 通过名字进行引用
l$c
l[c("a", "b", "c")]

dairy <- list(milk = "1 gallon", butter = "1 pound", eggs = 12)
dairy$milk
dairy[["milk"]]
# 非精确匹配
dairy[["mi", exact = FALSE]]

# 列表的列表
fruit <- list(apples = 6, oranges = 3, bananas = 10)
shopping <- list(dairy = dairy, fruit = fruit)
shopping
shopping$dairy
shopping$dairy$milk
shopping[[c("dairy", "milk")]]
shopping[[c(1, 2)]]

# 长度减小与增大
w <- seq(0, 25, 5)
length(w)
w
# 长度减小
length(w) <- 5
w
# 长度增大
length(w) <- 10
w

# matrix
m <- matrix(data = 1:12, nrow = 4, ncol = 3,
            dimnames = list(
              c("r1", "r2", "r3", "r4"),
              c
              )
            )
m

# array
a <- array(data = 1:24, dim = c(3, 4, 2), dimnames = list(
  # 顺序要对应
  c("r1", "r2", "r3"),
  c("c1", "c2", "c3", "c4"),
  c("arr1", "arr2")
  )
  )
a

# 因子
eye <- factor(c("brown", "green", "green", "grown", "black", "blue", "black"))
eye
levels(eye)

# data.frame
c <- data.frame(
  city = c("se", "wa", "ch", "ny", " po"),
  rank = c(100, 96, 94, 93, 93)
)
c
c$city

ts(1:8, start = c(2008, 2), frequency = 4)

all.equal(a, f)
identical(a, b)







