glv <- function(time, x, param){
  
  with(param, {
    # sapply does cbind on resulting cols
    dx <- alpha*x + ((c0 + t(sapply(ck, function(m) m%*%x)))%*%x)*x
    
    return(list(dx))
  })
}


growthFunction <- function(N, alpha, c0, ck, init){
  
  dat <- data.frame(lsoda(init, 0:300, glv, list(alpha=alpha, c0=c0, ck=ck)))
  
  matplot(x = dat$time,
          y = dat[,-1],
          typ = 'b',
          xlab = 'Time',
          ylab = 'Abundance',
          main = paste('Modified GLV-density', N,'species'))
  
  return(dat)
}
