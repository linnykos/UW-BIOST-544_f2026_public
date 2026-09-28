# HW1, Q3: A survival workflow on the NCCTG lung cancer data
# BIOST 544, Autumn 2026
#
# Run this line by line in RStudio. The data ship with the survival package,
# so there is nothing to download and nothing is written to your machine.

# install.packages("survival")

library(survival)

rm(list = ls())

# The data ---------------------------------------------------------------------

# `lung` is loaded with the package. The older call `data(lung)` now warns,
# because the package stores the dataset under the name `cancer`.
lung_df <- survival::lung
dim(lung_df)
utils::head(lung_df)
table(lung_df$status)
table(lung_df$sex)

# The survival outcome ---------------------------------------------------------

# status is 1 for a censored patient and 2 for a patient who died, so the
# event indicator is `status == 2`.
surv_obj <- survival::Surv(lung_df$time, lung_df$status == 2)
utils::head(surv_obj)

# Kaplan-Meier curves by sex ---------------------------------------------------

km_fit <- survival::survfit(
  Surv(time, status == 2) ~ sex, data = lung_df)
km_fit
