#' Generate all possible initial state of community
#' 
#' To generate a matrix of all possible combination of species presence (1) or 
#' absence (0) as an initial state of the community. For a community of \code{N} 
#' species, there are \code{2^N} possibilities.
#'
#' @param N Total number of species in the community.
#'
#' @return A matrix of 2^NxN, with values 1 indicating the presence and 0 the 
#' absence of the species.
#' @export
#'
#' @examples
#' mask <- function(4)
#' initAbundance <- c(1, 3, 2, 4)
#' # Initial abundance for all 16 scenarios
#' allInitAbundance <- t(t(mask) * initAbundance)
#' 
binaryInitState <- function(N){
  
  repeatBinaryNTimes <- rep(list(c(0,1)),N)
  mask <- expand.grid(repeatBinaryNTimes)
  
  # Randomize rows
  mask <- mask[sample(nrow(mask)), ]
  
  return(mask)
}