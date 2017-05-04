data {
  // number of observations
  int N;
  // response
  int<lower = 0> y[N];
  // design matrix X
  vector[N] hamilton;
}
parameters {
  // regression coefficient vector
  real a;
  real b;
}
model {
  a ~ normal(0, 10);
  b ~ normal(0, 2.5);
  // likelihood
  y ~ poisson_log(a + b * hamilton);
}
generated quantities {
  // simulate data from the posterior
  vector[N] y_rep;
  // log-likelihood posterior
  vector[N] log_lik;
  // means
  vector<lower = 0.>[N] lambda;
  for (i in 1:N) {
    lambda[i] = fmax(0., exp(a + b * hamilton[i]));
    y_rep[i] = poisson_rng(lambda[i]);
    log_lik[i] = poisson_lpmf(y[i] | lambda[i]);
  }
}
