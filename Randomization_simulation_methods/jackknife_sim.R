library(tidyverse)
library(furrr)

set.seed(324628764)


biased_sd <- function(x) {
  sqrt(sum((x - mean(x)) ^ 2) / length(x))
}


jackknife_sd <- function(x) {
  ps <- numeric(length(x))
  for (ii in 1:length(x)) {
    x_sub <- x[-ii]
    ps[ii] <- length(x) * biased_sd(x) - length(x_sub) * biased_sd(x_sub)
  }
  return(mean(ps))
}

sim_sds <- function(ii, xbar, xsd, n) {
  x <- rnorm(n, xbar, xsd)

  x_sd <- sd(x)
  x_biased_sd <- biased_sd(x)
  x_jackkife_sd <- jackknife_sd(x)

  return(tibble(x_sd, x_biased_sd, x_jackkife_sd))
}

plan(multisession, workers = 5)
sims <- future_map(.x = seq_len(1e4),
                   .f = sim_sds,
                   xbar = 0,
                   xsd = 1,
                   n = 50,
                   .progress = TRUE,
                   .options = furrr_options(seed = TRUE)) |>
  list_rbind()
plan(sequential)

sims_long <- pivot_longer(sims, cols = -x_sd)

ggplot(sims_long, aes(x = x_sd, y = value, color = name)) +
  geom_abline(slope = 1, intercept = 0) +
  geom_point() +
  facet_grid(name ~ .) +
  cowplot::theme_cowplot()

sims <- sims |>
  mutate(d_biased = x_biased_sd - x_sd,
         d_jackknife = x_jackkife_sd - x_sd)

sims |>
  select(starts_with("d")) |>
  pivot_longer(cols = everything()) |>
  ggplot(aes(value)) +
  geom_vline(xintercept = 0, color = "red") +
  geom_histogram(bins = 50) +
  facet_grid(. ~ name) +
  cowplot::theme_cowplot()

