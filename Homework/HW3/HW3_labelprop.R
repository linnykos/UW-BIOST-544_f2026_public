# HW3, Q3: Label propagation vs. logistic regression on 10 labels
# BIOST 544, Autumn 2026
#
# Run this line by line in RStudio. The data ship with the mlbench package, so
# there is nothing to download and nothing is written to your machine.

# install.packages("mlbench")

library(mlbench)

rm(list = ls())

# The data ---------------------------------------------------------------------

utils::data(BreastCancer, package = "mlbench")
bc_df <- BreastCancer[stats::complete.cases(BreastCancer), ]
dim(bc_df)

# The 9 features are stored as factors with levels 1 to 10, so they are
# converted to numbers through as.character(). Calling as.numeric() on a
# factor directly would return the level positions instead of the values.
x_mat <- sapply(bc_df[, 2:10], function(v){
  as.numeric(as.character(v))
})
y_vec <- as.numeric(bc_df$Class == "malignant")
dim(x_mat)
table(y_vec)

# The neighbor graph and label propagation -------------------------------------

build_knn_graph <- function(x_mat, k = 10){
  dist_mat <- as.matrix(stats::dist(scale(x_mat)))
  n <- nrow(x_mat)
  w_mat <- matrix(0, nrow = n, ncol = n)
  for(i in seq_len(n)){
    neighbor_vec <- order(dist_mat[i, ])[2:(k + 1)]
    w_mat[i, neighbor_vec] <- 1
  }
  pmax(w_mat, t(w_mat))
}

propagate_labels <- function(w_mat, y_labeled, idx_labeled,
                             num_iter = 1000){
  f_vec <- rep(0.5, nrow(w_mat))
  f_vec[idx_labeled] <- y_labeled
  for(iter in seq_len(num_iter)){
    f_vec <- as.vector(w_mat %*% f_vec) / rowSums(w_mat)
    f_vec[idx_labeled] <- y_labeled
  }
  f_vec
}

# Many biopsies share the same 9 scores, so distances tie often. order()
# breaks each tie by row number, which makes the graph reproducible.
w_mat <- build_knn_graph(x_mat, k = 10)
sum(w_mat) / 2

# Ten biopsies sent for expert review ------------------------------------------

set.seed(544)
idx_labeled <- c(sample(which(y_vec == 0), 5),
                 sample(which(y_vec == 1), 5))
y_vec[idx_labeled]
