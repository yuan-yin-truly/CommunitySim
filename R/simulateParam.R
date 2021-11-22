simulateParam <- function(N){
  
  # Species intrinsic growth rate
  alpha <- runif(N)
  
  
  # Pairwise interaction: interaction from col species to row species
  c0 <- runif(N**2, min = -1, max = 0)
  c0 <- matrix(c0, nrow = N)
  diag(c0) <- -0.5
  
  
  # Higher order effect: impact on each ith species. For each matrix,
  # interaction from col (i.e. 3rd species) species.
  ck <- list()
  
  for (i in 1:N) {
    temp <- runif(N**2, min = -1, max = 0.2)
    temp <- matrix(temp, nrow = N)
    
    temp[i,] <- 0
    temp[,i] <- 0
    diag(temp) <- 0
    
    ck[[i]] <- temp
  }
  
  # Initial state of community
  init <- runif(N, min = 1, max = 10)/10
  
  re <- list(N = N, alpha = alpha, c0 = c0, ck = ck, init = init)
  return(re)
  
}