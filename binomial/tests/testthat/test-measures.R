context("Check summary measures")

test_that("aux_mean with correct output", {
  expect_equal(aux_mean(5, 0.3), 1.5)
  expect_equal(aux_mean(10, 0.4), 4)
  expect_type(aux_mean(0.3, 0.6), 'double')
})

test_that("aux_variance with correct output", {
  expect_equal(aux_variance(5, 0.3), 1.05)
  expect_equal(aux_variance(10, 0.4), 2.4)
  expect_type(aux_variance(0.3, 0.6), 'double')
})

test_that("aux_mode with correct output",{
  expect_equal(aux_mode(5, 0.3), 1)
  expect_equal(aux_mode(9, 0.5), c(5, 6))
  expect_type(aux_mode(5, 0.6), 'double')
})

test_that("aux_skewness with correct output",{
  expect_lt(aux_skewness(5, 0.3) - 0.39036, 10e-08)
  expect_equal(aux_skewness(9, 0.5), 0)
  expect_type(aux_skewness(5, 0.6), 'double')
})

test_that("aux_kurtosis with correct output",{
  expect_lt(aux_kurtosis(5, 0.3) + 0.247619, 10e-08)
  expect_equal(aux_kurtosis(10, 0.5), -0.2)
  expect_type(aux_skewness(5, 0.6), 'double')
})
