# HW2, Q1: Adjusting for a confounder vs. a collider
# BIOST 544, Autumn 2026
#
# Run this line by line in RStudio. The file defines two functions that
# simulate an observational study of a drug dose, one in which the third
# variable is a confounder and one in which it is a collider, and then draws
# one dataset from each with the seed that the homework prints. Nothing is
# written to your machine.

rm(list = ls())

# The two generators -----------------------------------------------------------

simulate_confounder <- function(n){
  z <- stats::rnorm(n)
  d <- 2 + z + stats::rnorm(n)
  y <- 10 + 0.5 * d + z + stats::rnorm(n)
  data.frame(d = d, z = z, y = y)
}

simulate_collider <- function(n){
  d <- 2 + stats::rnorm(n, sd = sqrt(2))
  y <- 10 + 0.5 * d + stats::rnorm(n, sd = sqrt(1.5))
  z <- d + y + stats::rnorm(n)
  data.frame(d = d, z = z, y = y)
}

# One dataset from each --------------------------------------------------------

set.seed(544)
conf_df <- simulate_confounder(n = 500)
coll_df <- simulate_collider(n = 500)

utils::head(conf_df)
summary(conf_df)
summary(coll_df)
