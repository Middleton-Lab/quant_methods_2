data {
  int<lower=0> N;  // Number of observations
  vector[N] DBH;   // Vector of DBH values
}

parameters {
  real mu;             // logmean
  real<lower=0> sigma; // logsd
}

model {
  DBH ~ lognormal(mu, sigma);

  mu ~ normal(3, 0.2);     // Prior for mu
  sigma ~ normal(1, 0.25); // Prior for sigma
}
