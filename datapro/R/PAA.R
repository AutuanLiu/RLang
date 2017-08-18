# Piecewise Aggregate Approximation of time series
# https://jmotif.github.io/sax-vsm_site/morea/algorithm/PAA.html
# PAA算法的实现
paa <- function(ts, paa_size){
  len = length(ts)
  if (len == paa_size) {
    ts
  }
  else {
    if (len %% paa_size == 0) {
      colMeans(matrix(ts, nrow=len %/% paa_size, byrow=F))
    }
    else {
      res = rep.int(0, paa_size)
      for (i in c(0:(len * paa_size - 1))) {
        idx = i %/% len + 1 # the spot
        pos = i %/% paa_size + 1 # the col spot
        res[idx] = res[idx] + ts[pos]
      }
      for (i in c(1:paa_size)) {
        res[i] = res[i] / len
      }
      res
    }
  }
}

# https://jmotif.github.io/sax-vsm_site/morea/algorithm/znorm.html
# https://jmotif.github.io/sax-vsm_site/morea/algorithm/SAX.html
# https://jmotif.github.io/sax-vsm_site/morea/algorithm/SlidingWindowSAX.html
# Z-normalization of time series.
znorm <- function(ts){
  ts.mean <- mean(ts)
  ts.dev <- sd(ts)
  (ts - ts.mean)/ts.dev
}