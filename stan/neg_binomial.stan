data {
  // number of observations
  int N;
  // response
  int<lower = 0> y[N];
  // indicator variable for whether the observation is equal to hamilton
  vector[N] hamilton;
}
parameters {
  // regression coefficients
  real a;
  real b;
  // dispersion is 1 / phi
  real<lower = 0.> phi_reciprocal;
}
transformed parameters {
  real<lower = 0.> phi;
  vector<lower = 0.>[N] mu;
  phi = 1. / phi_reciprocal;
  mu = exp(a + hamilton * b);
}
model {
  a ~ normal(0., 10.);
  b ~ normal(0., 2.5);
  // putting prior on 1 / phi allows shrinking to no dispersion
  phi_reciprocal ~ cauchy(0., 5.);
  // likelihood
  y ~ neg_binomial_2(mu, phi);
}
generated quantities {
  // simulate data from the posterior
  vector[N] y_rep;
  vector[N] log_lik;
  // log-likelihood posterior
  for (i in 1:N) {
    y_rep[i] = neg_binomial_2_rng(mu[i], phi);
    log_lik[i] = neg_binomial_2_lpmf(y[i] | mu[i], phi);
  }
}
