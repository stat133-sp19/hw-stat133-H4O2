context("Check binomial arguments")

test_that("check_prob with legal probability", {
  expect_error(check_prob(2))
  expect_error(check_prob('prob'))
  expect_error(check_prob(c(0.3, 0.6)))
})

test_that("check_trial with legal numbers of trials", {
  expect_error(check_trials(c(0.5, 2)))
  expect_error(check_trials('prob'))
  expect_true(check_trials(3))
})

test_that("check_success with legal number of success",{
  expect_error(check_success(c(0.5, 2), 3))
  expect_error(check_success('prob', 2))
  expect_error(check_success(-1, 2))
  expect_error(check_success(c(2,4), 3))
})
