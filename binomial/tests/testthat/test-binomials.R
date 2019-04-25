context("Check binomial functions")

test_that("bin_choose with wrong output", {
  expect_equal(bin_choose(5, 3), 10)
  expect_error(bin_choose(10, 14))
  expect_error(bin_choose(3, c(2,6)))
})

test_that("bin_probability with wrong output", {
  expect_equal(bin_probability(2, 4, 0.5), 0.375)
  expect_error(bin_choose(13, 12, 0,5))
  expect_error(bin_choose(3, 4, 0.7))
})

test_that("bin_distribution with wrong output", {
  expect_error(bin_distribution(5, 10))
  expect_error(bin_distribution(10))
  expect_identical(class(bin_distribution(10, 0.5)), c('bindis', 'data.frame'))
})

test_that("bin_cumulative with wrong output", {
  expect_error(bin_cumulative(5, 10))
  expect_error(bin_cumulative(10))
  expect_identical(class(bin_cumulative(10, 0.5)), c('bincum', 'data.frame'))
})

