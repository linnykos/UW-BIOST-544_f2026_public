# HW2, Q2: Matching vs. adjusting on the low birth weight data
# BIOST 544, Autumn 2026
#
# Run this line by line in RStudio. The data ship with the MASS package, so
# there is nothing to download and nothing is written to your machine.

# install.packages(c("MASS", "MatchIt"))

library(MASS)
library(MatchIt)

rm(list = ls())

# The data ---------------------------------------------------------------------

birthwt_df <- MASS::birthwt
dim(birthwt_df)
utils::head(birthwt_df)
table(birthwt_df$smoke)
table(birthwt_df$low)
table(birthwt_df$race)
