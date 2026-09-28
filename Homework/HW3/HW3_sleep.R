# HW3, Q1: Why a mixed model
# BIOST 544, Autumn 2026
#
# Run this line by line in RStudio. The data ship with the lme4 package, so
# there is nothing to download and nothing is written to your machine.

# install.packages(c("lme4", "ggplot2"))

library(lme4)
library(ggplot2)

rm(list = ls())

# The data ---------------------------------------------------------------------

sleep_df <- lme4::sleepstudy
dim(sleep_df)
utils::head(sleep_df)
table(sleep_df$Subject)

# Participants who left the protocol early -------------------------------------

# In the original study every participant has all 10 days (Days 0 to 9).
# Here each participant stays for a random number of days between 3 and 10,
# as if some had dropped out of the protocol early.
subject_vec <- levels(sleep_df$Subject)
set.seed(544)
num_days_vec <- sample(3:10, size = length(subject_vec),
                       replace = TRUE)
names(num_days_vec) <- subject_vec
subject_chr <- as.character(sleep_df$Subject)
keep_vec <- sleep_df$Days < num_days_vec[subject_chr]
sleep_df <- sleep_df[keep_vec, ]
num_days_vec
nrow(sleep_df)

# One panel per participant ----------------------------------------------------

aes_obj <- ggplot2::aes(x = Days, y = Reaction)
plot1 <- ggplot2::ggplot(sleep_df, aes_obj)
plot1 <- plot1 + ggplot2::geom_point()
plot1 <- plot1 + ggplot2::facet_wrap(~ Subject, nrow = 3)
plot1 <- plot1 + ggplot2::xlab("Days of sleep restriction")
plot1 <- plot1 + ggplot2::ylab("Average reaction time (ms)")
plot(plot1)
