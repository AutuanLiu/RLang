# 自定义运算符
`%myop%`<-function(a,b){
  2*a+b^2
}
# 调用自定义运算符
1 %myop% 2   # 6

v<-c(1:8)
dim(v)<-c(2,4)
# ifelse
if (2 > 3) {
  "yes"
} else {
  "blue"
}

a<-c("a", "a", "a", "a", "a")
b<-c("b", "b", "b", "b", "b")

ifelse(c(TRUE, FALSE, TRUE, FALSE, TRUE),a, b)

f<-function(x){
  if (x == "a") {
    "camel"
  } else if (x == "b") {
    "bear"
  } else if (x == "c") {
    "apple"
  } else {
    "mouse"
  }
}

f("a"); f("c")

# switch
fs<-function(x) {
  switch(x,
         a = "alligator",
         b = "bear",
         c = "camel",
             "mouse"
         )
}

fs("c"); fs("d")

# repeat
i <- 5
repeat(
  if (i > 25) {
    break
  } else {
    print(i);
    i <- i + 5
  }
)
 
# while
i <- 5 # i 要重置
while (i <= 25) {
  print(i);
  i <- i + 5
}

# for
for (i in seq(from = 5, to = 25, by = 5)) {
  print(i)
}

v <- 100:119
v[5]
v[1:5]
v[c(1, 6, 11, 16)]
v[[3]]

# 删除元素
v[-12:-1] 
v # v 本身并不发生变化
v[-12:-1][1:6][1] # 可以嵌套访问

# list
l <- list(a = 1, b = c(1:5), c = 3, d = 4, e = c(2:4), f = 0)
l[1:3]
l[-3:-1]

# matrix
m <- matrix(c(101:112), 3, 4)
m
m[3, 4]
m[1:2, 1:2]
m[1:2, ]
m[, 3:4]

# 以列优先存储
m[3]
m[4]
m[5]
m[12]


























































