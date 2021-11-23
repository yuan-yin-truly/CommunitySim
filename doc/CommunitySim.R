## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(CommunitySim)
library(reticulate)
use_condaenv("CommunitySimDemo")
# Need a conda env with numpy, seaborn, and scikit-learn for Machine Learning Case Study

## -----------------------------------------------------------------------------
N <- 8
params <- simulateParam(N)
print(diag(params$c0))

## -----------------------------------------------------------------------------
abundance <- growthFunction(params$N, params$alpha, params$c0, params$ck, params$init)

## -----------------------------------------------------------------------------
mask <- binaryInitState(N)
head(mask)

init <- t(t(mask) * params$init)
head(data.frame(init))

## ----fig.show='hide'----------------------------------------------------------
abun_list <- apply(init, 1, function(x) growthFunction(N, params$alpha, params$c0, params$ck, x))

## -----------------------------------------------------------------------------
matrixToSS <- function(densityMatrix){
  s <- apply(densityMatrix[, 2:(N+1)], 2, findSteadyState)
  return(s)
}

SS <- sapply(abun_list, matrixToSS)
SS <- t(SS)
#If SS abundance is too small, set to 0
SS[which(SS < 0.001)] = 0

