# HW1, Q1: Seeing power in a simulation
# BIOST 544, Autumn 2026
#
# Run this line by line in RStudio. The file defines one function that
# simulates one two-arm trial, and then calls it once so that you can see
# what it returns. Nothing is written to your machine.

rm(list = ls())

# One trial --------------------------------------------------------------------

simulate_trial <- function(n, delta = 0.4, sigma = 1){
  drug <- stats::rnorm(n, mean = 5 + delta, sd = sigma)
  placebo <- stats::rnorm(n, mean = 5, sd = sigma)
  data.frame(arm = rep(c("drug", "placebo"), each = n),
             biomarker = c(drug, placebo))
}

set.seed(544)
trial_df <- simulate_trial(n = 10)
dim(trial_df)
utils::head(trial_df)
tapply(trial_df$biomarker, trial_df$arm, mean)
