# HW3, Q2: Effective sample size under measurement error
# BIOST 544, Autumn 2026
#
# Run this line by line in RStudio. The file defines one function that
# simulates a cohort whose exposure is measured with error, and then draws one
# cohort with the seed that the homework prints. Nothing is written to your
# machine.

rm(list = ls())

# The generator ----------------------------------------------------------------

simulate_eiv <- function(n, beta = 0.15, sigma_u = 1){
  x <- stats::rnorm(n, mean = 0, sd = 1)
  w <- x + stats::rnorm(n, mean = 0, sd = sigma_u)
  y <- beta * x + stats::rnorm(n, mean = 0, sd = 1)
  data.frame(x = x, w = w, y = y)
}

# One cohort -------------------------------------------------------------------

set.seed(544)
eiv_df <- simulate_eiv(n = 500)
dim(eiv_df)
utils::head(eiv_df)
