# HW3, Q1: Doubly robust estimation: which model has to be right?
# BIOST 544, Autumn 2026
#
# Run this line by line in RStudio. The file defines one function that
# simulates a cohort with one confounder, a treatment, and an outcome, and
# then draws one cohort with the seed that the homework prints. Nothing is
# written to your machine.

rm(list = ls())

# The generator ----------------------------------------------------------------

# One confounder x, uniform between -2 and 2. The treatment a follows a
# logistic model whose logit is a straight line in x, and the outcome y
# depends on x through a curve (a cubic) and on a through the true effect, 1.
# The two arguments put the curve into the propensity instead, or take it out
# of the outcome.
simulate_dr <- function(n, curved_outcome = TRUE,
                        curved_propensity = FALSE){
  x <- stats::runif(n, min = -2, max = 2)
  logit_vec <- -1 + 1.5 * x
  if(curved_propensity){
    logit_vec <- logit_vec + 1 - 0.75 * x^2
  }
  prob_vec <- stats::plogis(logit_vec)
  a <- stats::rbinom(n, size = 1, prob = prob_vec)
  mean_vec <- 1 + 1 * a + 2 * x
  if(curved_outcome){
    mean_vec <- mean_vec + 1.5 * x^2 + 0.5 * x^3
  }
  y <- mean_vec + stats::rnorm(n, mean = 0, sd = 1)
  data.frame(x = x, a = a, y = y)
}

# One cohort -------------------------------------------------------------------

set.seed(544)
dr_df <- simulate_dr(n = 1000)
dim(dr_df)
utils::head(dr_df)
table(dr_df$a)
