library(bootstrap)

# function defination
shrinkage <- function(fit, k = 10) {
    require(bootstrap)
    theta.fit <- function(x, y) {
    lsfit(x, y)
  }
  
    theta.predict <- function(fit, x) {
    cbind(1, x) %*% fit$coef
  }
  
     x <- fit$model[, 2:ncol(fit$model)]
     y <- fit$model[, 1]

     result <- crossval(x, y, theta.fit, theta.predict, ngroup = k)
     r2 <- cor(y, fit$fitted.value)^2
     r2cv <- cor(y, result$cv.fit)^2
     cat("Original R-Squre = ", r2, "\n")
     cat(k, "Fold Cros-Validated R-Squre = ", r2cv, "\n")
     cat("Change = ", r2 - r2cv, "\n\n")
}

states <- as.data.frame(state.x77[, c("Murder", "Population", "Illiteracy", "Income", "Frost")])
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
shrinkage(fit)

fit1 <- lm(Murder ~ Population + Illiteracy, data = states)
shrinkage(fit1)