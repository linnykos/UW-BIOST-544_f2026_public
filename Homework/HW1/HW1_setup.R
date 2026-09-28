# HW1: Check that your computer has what this homework needs
# BIOST 544, Autumn 2026
#
# Run this file once, before you start the homework. If every line runs
# without an error, you have everything the starter code needs.

install.packages("survival")
# Only if you will knit your answers into an .html file:
# install.packages("rmarkdown")

library(survival)

# Q3: the NCCTG lung cancer data ship with survival
dim(survival::lung)
