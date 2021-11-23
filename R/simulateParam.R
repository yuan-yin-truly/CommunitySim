#' Simulate parameters for community simulation
#'
#' Simulate intrinsic growth rate of species in the community, and their 
#' interaction intensity. Interaction intensity are mostly negative to reflect 
#' the competitive nature in the community, and values are drawn from a uniform
#' distribution.
#' 
#' @param N Number of members in the community.
#'
#' @return A list of parameters for community simulation. \code{N} is the input.
#' \code{alpha} is the intrinsic growth rate. \code{c0[i,j]} is the pairwise 
#' interaction intensity from species \code{j} to species \code{i}. \code{ck} is 
#' a list of length \code{N}, each matrix \code{k} being the higher order
#' impact from species j onto the pairwise interaction of \code{i} and \code{k},
#' felt by \code{k}.
#' @export
#'
#' @examples
#' re <- simulateParam(5)
#' alpha <- re$alpha
#' 
simulateParam <- function(N){
  
  # Species intrinsic growth rate
  alpha <- stats::runif(N, min = 0, max = 0.5)
  
  
  # Pairwise interaction: interaction from col species to row species
  c0 <- stats::runif(N**2, min = -0.2, max = 0.1)
  c0 <- matrix(c0, nrow = N)
  diag(c0) <- -0.5
  
  
  # Higher order effect: impact on each i-th species. For each matrix,
  # interaction from col (i.e. 3rd species) species.
  ck <- list()
  
  for (i in 1:N) {
    temp <- stats::runif(N**2, min = -0.1, max = 0.02)
    temp <- matrix(temp, nrow = N)
    
    temp[i,] <- 0
    temp[,i] <- 0
    diag(temp) <- 0
    
    ck[[i]] <- temp
  }
  
  # Initial state of community
  init <- stats::runif(N, min = 0, max = 0.01)
  
  re <- list(N = N, alpha = alpha, c0 = c0, ck = ck, init = init)
  return(re)
  
}