# https://hyunjimoon.github.io/SBC/

library(SBC)
gen <- SBC_example_generator("normal")

# interface = "cmdstanr" or "rjags" is also supported
backend_bad <- SBC_example_backend("normal_bad", interface = "rstan")

ds <- generate_datasets(gen, n_sims = 50)
results_bad <- compute_SBC(ds, backend_bad)

plot_rank_hist(results_bad)
plot_ecdf_diff(results_bad)

backend_sd <- SBC_example_backend("normal_sd", interface = "rstan")
results_sd <- compute_SBC(ds, backend_sd)

plot_rank_hist(results_sd)
plot_ecdf_diff(results_sd)
