testthat::test_that("growthFunction returns a DataFrame", {
  
  re <- simulateParam(4)
  dat <- growthFunction(re$N, re$alpha, re$c0, re$ck, re$init)
  
  testthat::expect_true(is.data.frame(dat))

})