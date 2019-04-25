library(ggplot2)
library(roxygen2)
# private funciton to check the probability
check_prob <- function(prob) {
  if (length(prob) > 1) {
    stop("'prob' must have only 1 value")
  }
  if (!is.numeric(prob)) {
    stop("\n'prob' must be a real number")
  }
  if (prob < 0 | prob > 1) {
    stop("\n'prob' values must be between 0 and 1")
  }
  return(TRUE)
}
# private funciton to check the trial numbers
check_trials <- function(trials) {
  if (length(trials) > 1) {
    stop("'trials' must have only 1 value")
  }
  if (!is.numeric(trials) | round(trials) != trials) {
    stop("invalid trials value")
  }
  return(TRUE)
}
# check the number of success is legal or not
check_success <- function(success, trials) {
  if (!is.vector(success)) {
    stop("success should be a vector")
  }
  if (mode(success) != "numeric" | any(round(success) != success)){
    stop("success only contain integers values")
  }
  if (any(success > trials)){
    stop("success cannot be greater than trials")
  }
  if (any(success < 0)){
    stop("success cannot be less than 0")
  }
  return(TRUE)
}

# auxiliary functions for calculating mean
aux_mean <- function(trials, prob){
  return(trials * prob)
}

# auxiliary functions for calculating variance
aux_variance <- function(trials, prob){
  return(trials * prob * (1-prob))
}

# auxiliary functions for calculating mode
aux_mode <- function(trials, prob){
  if (round(trials * prob + prob) == trials * prob + prob){
    return(c(round(trials * prob + prob), round(trials * prob + prob) + 1))
  }
  return(floor(trials * prob + prob))
}

# auxiliary functions for calculating skewness
aux_skewness <- function(trials, prob){
  return((1 - 2 * prob)/sqrt(trials * prob *(1 - prob)))
}

# auxiliary functions for calculating kurtosis
aux_kurtosis <- function(trials, prob){
  return((1 - 6 * prob * (1 - prob))/(trials * prob *(1 - prob)))
}

#' @title Binomial Choose
#' @description the function used to calculate the combinatorial number of
#' @param n an integer with number of trials
#' @param k a list with number of success
#' @return an integer represents the number of combinations
#' @export
#' @examples
#' bin_choose(10, 4)
bin_choose <- function(n, k){
  if (any(k > n)){
    stop("k cannot be greater than n")
  }
  return(factorial(n)/(factorial(n-k) * factorial(k)))
}

#'@title Binomial Probability
#'@description the function used to calculate the probablity of the binomial random variable
#'@param trials an integer with number of trials
#'@param success a list with number of success
#'@param prob the probability of the success occur
#'@return a list containging the probability of success given trials and success
#'@export
#'@examples
#'bin_probability(3, 5, 0.5)
bin_probability <- function(success, trials, prob){
  check_trials(trials)
  check_prob(prob)
  check_success(success, trials)
  return(bin_choose(trials, success) * prob ^ success * (1-prob) ^ (trials-success))
}

#'@title Binomial Distribution
#'@description the function used to calculate the probability and return a dataframe
#'@param trials an integer with number of trials
#'@param prob the probability of the success occur
#'@return a data.frame containing the success and corresponding probability
#'@export
#'@examples
#'bin_distribution(10, 0.5)
bin_distribution <- function(trials, prob){
  df <- data.frame(0:trials, bin_probability(0:trials, trials, prob))
  names(df) <- c("success", "probability")
  df <- structure(df, class = c("bindis", "data.frame"))
  return(df)
}

#' @export
plot.bindis <- function(bindis){
  ggplot(bindis, aes(x = success, y = probability))+
    geom_col()
}

#'@title Binomial Cumulative
#'@description the function used to calculate the cumulative probability and return a dataframe
#'@param trials an integer with number of trials
#'@param prob the probability of the success occur
#'@return a data.frame containing the success and corresponding probability as well as cumulatve probability
#'@export
#'@examples
#'bin_cumulative(10, 0.5)
bin_cumulative <- function(trials, prob){
  probability <- bin_probability(0:trials, trials, prob)
  sum <- 0
  cumulative <- c()
  for (i in 1:(trials+1)){
    sum <- sum +  probability[i]
    cumulative[i]  <- sum
  }
  df <- data.frame(0:trials, probability, cumulative)
  names(df) <- c("success", "probability", "cumulative")
  df <- structure(df, class = c("bincum", "data.frame"))
  return(df)
}

#' @export
plot.bincum <- function(bincum){
  ggplot(bincum, aes(x = success, y = cumulative))+
    geom_line(color = "skyblue")+
    geom_point(colour = "skyblue2", size = 1.5)
}

#'@title Binomial Variable
#'@description the function used to generate a binomial variable with class 'binvar'
#'@param trials an integer with number of trials
#'@param prob the probability of the success occur
#'@return a 'binvar' class object containing the number of trials and the probability of success
#'@export
#'@examples
#' bin_variable(10, 0.5)
bin_variable <- function(trials, prob){
  check_prob(prob)
  check_trials(trials)
  l <- list(trials, prob)
  names(l) <- c("number of trials", "probability of success")
  l <- structure(l, class = "binvar")
  return(l)
}

#' @export
print.binvar <- function(binvar){
  print("Binomial Variable")
  print('Parameter')
  print(paste("- number of trials:", binvar[[1]]))
  print(paste("- prob of success:", binvar[[2]]))
}

#' @export
summary.binvar <- function(binvar){
  mean <- aux_mean(binvar[[1]], binvar[[2]])
  variance <- aux_variance(binvar[[1]], binvar[[2]])
  mode <- aux_mode(binvar[[1]], binvar[[2]])
  skewness <- aux_skewness(binvar[[1]], binvar[[2]])
  kurtosis <- aux_kurtosis(binvar[[1]], binvar[[2]])
}
#' @export
print.summary.binvar <- function(binvar){
  print("Summary Binomial")
  print('Parameter')
  print(paste("- number of trials:", binvar[[1]]))
  print(paste("- prob of success:", binvar[[2]]))
  print('Measure')
  print(paste("- mean:", mean))
  print(paste("- variance:", variance))
  print(paste("- mode", mode))
  print(paste("- skewness", mode))
  print("- kurtosis", mode)
}
#'@title Binomial Mean
#'@description Calculate the mean of binomial distribution
#'@param trials an integer with number of trials
#'@param prob the probability of the success occur
#'@return the mean value
#'@export
#'@examples
#'bin_mean(10, 0.5)
bin_mean <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_mean(trials, prob))
}

#'@title Binomial Variance
#'@description Calculate the variance of binomial distribution
#'@param trials an integer with number of trials
#'@param prob the probability of the success occur
#'@return the variance value
#'@export
#'@examples
#'bin_variance(10, 0.5)
bin_variance <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_variance(trials, prob))
}

#'@title Binomial Mode
#'@description Calculate the mode of binomial distribution
#'@param trials an integer with number of trials
#'@param prob the probability of the success occur
#'@return the mode value
#'@export
#'@examples
#'bin_mode(10, 0.5)
bin_mode <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_mode(trials, prob))
}

#'@title Binomial Skewness
#'@description Calculate the skewness of binomial distribution
#'@param trials an integer with number of trials
#'@param prob the probability of the success occur
#'@return the skewness value
#'@export
#'@examples
#'bin_skewness(10, 0.5)
bin_skewness <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_skewness(trials, prob))
}

#'@title Binomial Kurtosis
#'@description Calculate the kurtosis of binomial distribution
#'@param trials an integer with number of trials
#'@param prob the probability of the success occur
#'@return the kurtosis value
#'@export
#'@examples
#' bin_kurtosis(10, 0.5)
bin_kurtosis <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_kurtosis(trials, prob))
}

