# HW3: Check that your computer has what this homework needs
# BIOST 544, Autumn 2026
#
# Run this file once, before you start the homework. If every line runs
# without an error, you have everything the starter code needs.

install.packages(c("glmnet", "mlbench"))
# Only if you will knit your answers into an .html file:
# install.packages("rmarkdown")

library(glmnet)
library(mlbench)

# Q1 simulates its data; its lasso part uses glmnet
packageVersion("glmnet")
# Q3: the Wisconsin breast cancer data ship with mlbench
utils::data(BreastCancer, package = "mlbench")
dim(BreastCancer)
