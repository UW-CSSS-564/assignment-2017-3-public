1.  Fork this repository to your account
2.  Edit the file `solutions.Rmd` with your solutions to the problems.
3.  Submit a pull request to have it graded. Include either or both a
    HTML and PDF file.

For updates and questions follow the Slack channel:
[\#assignment3](https://uwcsss564.slack.com/messages/C516ETYBY).

This assignment will require the following R packages:

    library("rstan")

Statistical Simulation
======================

Read @KingTomzWittenberg2000a. They propose a statistical simulation
approach for interpreting statistical analysis; see section
"Simulation-Based Approaches to Interpretation". Compare and contrast
this to a full Bayesian approach.

Student-t Prior
===============

The robust regression with Student-t error example uses the following
prior on the degrees of freedom parameter.
*ν* ∼ *G**a**m**m**a*(2, 0.01)
 The Student-t distribution is used because it has wider tails and thus
is less sensitive to outliers than a normal distribution. However, the
researcher generally has no information about the value of the degrees
of freedom.

1.  Plot this prior distribution, and the values of the 5th and 95th
    quantiles. You can use `dgamma(x, 2, scale = 0.01)` and
    `qgamma(x, 2, scale = 0.01)`. What is
2.  Additionally, the prior is truncated at 2. Why? Hint: What moments
    of the Student-t distribution are not-defined for values between 2.

Student-t as a Mixture of Normals
=================================

The Student-t distribution is a scale mixture of normals.[1] This means
that a Student-t distribution can be represented as normal distributions
in which the variances are drawn from different distributions. Suppose
*X* is distributed Student-t with degrees of freedom *ν*, location *μ*,
and scale *σ*,
*X* ∼ *t*<sub>*ν*</sub>(*μ*, *σ*).
 Samples from *Y* can be drawn by
*x*<sub>*i*</sub> ∼ *N*(*μ*, *λ*<sub>*i*</sub><sup>2</sup>*γ*<sup>2</sup>)
 If the local variance parameters are distributed inverse-gamma
1/*λ*<sup>2</sup> ∼ Gamma(*ν*/2, *ν*/2).

Many distributions used in regression shrinkage: Double Exponential
(Laplace), and Hierarchical Shrinkage (Horseshoe), have this
representation.

You can draw a sample from this:

    df <- 10
    n <- 1000
    sigma <- rgamma(n, 0.5 * df, 0.5 * df)
    x <- rnorm(n, sd = sqrt(1 / sigma ^ 2))

Plot samples drawn in this way against either samples or theoretical
values of the Student-t distribution. Try a few values of the degrees of
freedom. Try something small (3) and large (100).

You can draw samples directly from a Student-t with `rt`. A
quantile-quantile plot
([geom\_qq](http://ggplot2.tidyverse.org/reference/geom_qq.html)) or a
density plot with the function
([geom\_density](http://ggplot2.tidyverse.org/reference/geom_density.html)
and
[stat\_function](http://ggplot2.tidyverse.org/reference/stat_function.html)).

Note: there isn't a right answer to this. Well, actually, there is, and
you know it. They are equivalent, a proof is in the link. So for credit,
do a little work, and show it. This pattern appears often, so wrap your
head around it.

Separation
==========

Continue what was covered in class.

Transformations of Coefficients
===============================

@Rainey2016b notes that unbiased estimators of parameters does not imply
that transformations of those parameters are unbiased estimators.

Poisson and Negative Binomial Example
=====================================

Fill in

[1] mix
