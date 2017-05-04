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
  // reciprocal dispersion parameter
  real<lower = 0.> phi;
}
model {
  a ~ normal(0., 10.);
  b ~ normal(0., 2.5);
  phi ~ cauchy(0., 5.);
  // likelihood
  y ~ neg_binomial_2_log(a + b * hamilton, phi);
}
generated quantities {
  // simulate data from the posterior
  vector[N] y_rep;
  vector[N] log_lik;
  vector<lower = 0.>[N] mu;
  // log-likelihood posterior
  for (i in 1:N) {
    mu[i] = fmax(exp(a + b * hamilton[i]), 0.);
    y_rep[i] = neg_binomial_2_rng(mu[i], phi);
    log_lik[i] = neg_binomial_2_lpmf(y[i] | mu[i], phi);
  }
}
