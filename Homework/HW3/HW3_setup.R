# HW3: Check that your computer has what this homework needs
# BIOST 544, Autumn 2026
#
# Run this file once, before you start the homework. If every line runs
# without an error, you have everything the starter code needs.

install.packages(c("lme4", "ggplot2", "mlbench"))
# Only if you will knit your answers into an .html file:
# install.packages("rmarkdown")

library(lme4)
library(ggplot2)
library(mlbench)

# Q1: the sleep deprivation data ship with lme4
dim(lme4::sleepstudy)
# Q3: the Wisconsin breast cancer data ship with mlbench
utils::data(BreastCancer, package = "mlbench")
dim(BreastCancer)
