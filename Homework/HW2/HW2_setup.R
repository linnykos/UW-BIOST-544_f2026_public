# HW2: Check that your computer has what this homework needs
# BIOST 544, Autumn 2026
#
# Run this file once, before you start the homework. If every line runs
# without an error, you have everything the starter code needs.

install.packages(c("MASS", "MatchIt", "survival", "mice"))
# Only if you will knit your answers into an .html file:
# install.packages("rmarkdown")

library(MASS)
library(MatchIt)
library(survival)
library(mice)

# Q2: the low birth weight data ship with MASS
dim(MASS::birthwt)
# Q3: the NCCTG lung cancer data ship with survival
dim(survival::lung)
