logsumexp <- function(x) {
  k <- which.max(x)
  a <- x[k]
  x <- x[-k]
  w <- sum(exp(x - a))
  a + log1p(w)
}

logsumexp(1:5e4)

log(sum(exp(1:5e4)))
