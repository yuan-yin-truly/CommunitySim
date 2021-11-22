#' Find steady state value in a vector
#' 
#' Given a vector as the abundance level across time, find the value in the 
#' vector where the abundance has reached a steady state.
#'
#' @param vec An atomic vector of abundance level of a species across time.
#'
#' @return A scalar where steady state has reached.
#'
#' 
findSteadyState <- function(vec){
  for (i in 1:(length(vec) - 10)) {
    #From start, search for 3 points each 5 unit time apart where delta < 10^-3
    thisSlope <- abs(vec[i+1] - vec[i])
    nextSlope <- abs((vec[i+5] - vec[i])/5)
    lastSlope <- abs(vec[i+10] - vec[i+9])
    
    if (thisSlope < 10^-3 & nextSlope < 10^-3 & lastSlope < 10^-3) {
      
      #Extrapolate by thisSlope and calculate value at end of vec
      
      ExtrEndTimeValue = vec[i] + nextSlope*(length(vec) - i)
      if ((ExtrEndTimeValue < (vec[length(vec)]) + 0.001) & (ExtrEndTimeValue > (vec[length(vec)]) - 0.001)) {
        return(vec[i])
      }
      #There is a plateau in the middle, but in the end density changes again: find next plateau and verify again
    }
  }
  #Til the end no steady state found
  return(NaN)
}
