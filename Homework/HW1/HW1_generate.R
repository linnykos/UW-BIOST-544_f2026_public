# HW1, Q2: Randomized or observed, is the drug causal?
# BIOST 544, Autumn 2026
#
# Run this line by line in RStudio. The file defines two functions that
# simulate a study of a blood-pressure drug, one randomized and one
# observational, and then draws one dataset from each with the seed that the
# homework prints. Nothing is written to your machine.

rm(list = ls())

# The two generators -----------------------------------------------------------

simulate_rct <- function(n){
  z <- stats::rnorm(n)
  a <- stats::rbinom(n, size = 1, prob = 0.5)
  y <- 140 - 5 * a + 8 * z + stats::rnorm(n, sd = 10)
  data.frame(a = a, z = z, y = y)
}

simulate_obs <- function(n){
  z <- stats::rnorm(n)
  prob_vec <- stats::plogis(2 * z)
  a <- stats::rbinom(n, size = 1, prob = prob_vec)
  y <- 140 - 5 * a + 8 * z + stats::rnorm(n, sd = 10)
  data.frame(a = a, z = z, y = y)
}

# One dataset from each --------------------------------------------------------

set.seed(544)
rct_df <- simulate_rct(n = 500)
obs_df <- simulate_obs(n = 500)

utils::head(rct_df)
summary(rct_df)
summary(obs_df)
