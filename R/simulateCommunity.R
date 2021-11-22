#' Generalized Lotka-Volterra equation
#' 
#' The coupled ODE of growth rates of species in the community, with parameters
#' reflecting their interaction intensity. To be used as input to deSolve ODE 
#' solver.
#' 
#' @param time Time point for solver evaluation.
#' @param x Species abundance.
#' @param param Need alpha, c0 and ck. See growthFunction doc.
#'
#' 
glv <- function(time, x, param){
  
  with(param, {
    # sapply does cbind on resulting cols
    dx <- alpha*x + ((c0 + t(sapply(ck, function(m) m%*%x)))%*%x)*x
    return(list(dx))
  })
}


#' Simulate community
#' 
#' Simulate the dynamics of the abundance of the species in the community with 
#' parameters reflecting the interaction intensity among members of the 
#' community.
#'
#' @param N Number of members in the community.
#' @param alpha 1xN vector of intrinsic growth rate of each member of the 
#' community.
#' @param c0 NxN matrix of pairwise interaction intensity in the community. 
#' \code{c0[i,j]} is the impact of j on i per j unit.
#' @param ck A list of N matrix, each with NxN entries. \code{ck[[k]][i,j]} is
#' the higher order impact from species j onto the pairwise interaction of 
#' \code{i} and \code{k}, felt by \code{k}.
#' @param init 1xN vector of initial abundance of each member in the community.
#'
#' @return A DataFrame, with row being each time point and columns species. 
#' The abundance vs. time plot is also rendered.
#' @export
#'
#' @examples
#' # Simulate parameters for a 4 species community
#' param <- simulateParam(4)
#' abundance <- growthFunction(param$N, param$alpha, param$c0, param$ck, 
#' param$init)
#' 
growthFunction <- function(N, alpha, c0, ck, init){
  
  dat <- data.frame(deSolve::lsoda(init, 0:300, glv, list(alpha=alpha, c0=c0, ck=ck)))
  
  graphics::matplot(x = dat$time,
          y = dat[,-1],
          cex = 0.8,
          type = 'b',
          xlab = 'Time',
          ylab = 'Abundance',
          main = paste('Modified GLV', N,'species'))
  
  return(dat)
}
