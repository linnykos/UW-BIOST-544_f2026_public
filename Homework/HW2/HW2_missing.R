# HW2, Q3: Missing data and a tipping point on the NCCTG lung cancer data
# BIOST 544, Autumn 2026
#
# Run this line by line in RStudio. The data ship with the survival package,
# so there is nothing to download and nothing is written to your machine.
# The multiple imputation step takes a few seconds.

# install.packages(c("survival", "mice"))

library(survival)
library(mice)

rm(list = ls())

# The data and the outcome -----------------------------------------------------

lung_df <- survival::lung
# died_1yr is 1 for a patient who died by day 365, 0 for
# a patient followed past day 365, and NA for a patient
# censored before day 365.
is_dead_1yr <- lung_df$time <= 365 & lung_df$status == 2
is_alive_1yr <- lung_df$time > 365
lung_df$died_1yr <- ifelse(is_dead_1yr, 1,
                           ifelse(is_alive_1yr, 0, NA))
table(lung_df$died_1yr, useNA = "ifany")
colSums(is.na(lung_df))

# Complete-case analysis -------------------------------------------------------

fit_cc <- stats::glm(
  died_1yr ~ sex + age + ph.ecog + meal.cal,
  data = lung_df, family = stats::binomial)
summary(fit_cc)

# Multiple imputation under MAR ------------------------------------------------

var_vec <- c("sex", "age", "ph.ecog", "meal.cal", "died_1yr")
imp_df <- lung_df[, var_vec]
imp <- mice::mice(imp_df, m = 20, seed = 544,
                  printFlag = FALSE)
fit_mi <- with(imp, stats::glm(
  died_1yr ~ sex + age + ph.ecog + meal.cal,
  family = stats::binomial))
summary(mice::pool(fit_mi), conf.int = TRUE)

# A delta shift of the imputed caloric intake ----------------------------------

shift_meal_cal <- function(imp, delta){
  imp_delta <- imp
  # Each column of imp$imp$meal.cal holds the imputed
  # values of one imputed dataset. Replacing the columns
  # in place with [] keeps the data frame that
  # mice::complete() expects.
  shifted_list <- lapply(imp$imp$meal.cal, function(v){
    pmax(0, v - delta)
  })
  imp_delta$imp$meal.cal[] <- shifted_list
  imp_delta
}

imp_300 <- shift_meal_cal(imp, delta = 300)
fit_300 <- with(imp_300, stats::glm(
  died_1yr ~ sex + age + ph.ecog + meal.cal,
  family = stats::binomial))
summary(mice::pool(fit_300), conf.int = TRUE)
