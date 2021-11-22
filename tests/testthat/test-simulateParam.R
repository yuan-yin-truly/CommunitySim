testthat::test_that('Parameters simulated in the right range', {
  
  re <- simulateParam(6)
  minAlpha <- min(re$alpha)
  minCk <- max(sapply(re$ck, min))
  
  testthat::expect_gte(minAlpha, 0)
  testthat::expect_lte(minCk, 1)
  
})
