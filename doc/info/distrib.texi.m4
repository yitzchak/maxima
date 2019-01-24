@c -*- Mode: texinfo -*-
@menu
* Introduction to distrib::
* Functions and Variables for continuous distributions::
* Functions and Variables for discrete distributions::
@end menu

@node Introduction to distrib, Functions and Variables for continuous distributions, distrib-pkg, distrib-pkg
@section Introduction to distrib


Package @code{distrib} contains a set of functions for making probability computations on both discrete and continuous univariate models. 

What follows is a short reminder of basic probabilistic related definitions.

Let @math{f(x)} be the @var{density function} of an absolute continuous random variable @math{X}. The @var{distribution function} is defined as
@ifnottex
@example
                       x
                      /
                      [
               F(x) = I     f(u) du
                      ]
                      /
                       minf
@end example
@end ifnottex
@tex
$$F\left(x\right)=\int_{ -\infty }^{x}{f\left(u\right)\;du}$$
@end tex
which equals the probability @var{Pr(X <= x)}.

The @var{mean} value is a localization parameter and is defined as
@ifnottex
@example
                     inf
                    /
                    [
           E[X]  =  I   x f(x) dx
                    ]
                    /
                     minf
@end example
@end ifnottex
@tex
$$E\left[X\right]=\int_{ -\infty }^{\infty }{x\,f\left(x\right)\;dx}$$
@end tex

The @var{variance} is a measure of variation,
@ifnottex
@example
                 inf
                /
                [                    2
         V[X] = I     f(x) (x - E[X])  dx
                ]
                /
                 minf
@end example
@end ifnottex
@tex
$$V\left[X\right]=\int_{ -\infty }^{\infty }{f\left(x\right)\,\left(x
 -E\left[X\right]\right)^2\;dx}$$
@end tex
which is a positive real number. The square root of the variance is the @var{standard deviation}, @math{D[X]=sqrt(V[X])}, and it is another measure of variation.

The @var{skewness coefficient} is a measure of non-symmetry,
@ifnottex
@example
                 inf
                /
            1   [                    3
  SK[X] = ----- I     f(x) (x - E[X])  dx
              3 ]
          D[X]  /
                 minf
@end example
@end ifnottex
@tex
$$SK\left[X\right]={{\int_{ -\infty }^{\infty }{f\left(x\right)\,
 \left(x-E\left[X\right]\right)^3\;dx}}\over{D\left[X\right]^3}}$$
@end tex

And the @var{kurtosis coefficient} measures the peakedness of the distribution,
@ifnottex
@example
                 inf
                /
            1   [                    4
  KU[X] = ----- I     f(x) (x - E[X])  dx - 3
              4 ]
          D[X]  /
                 minf
@end example
@end ifnottex
@tex
$$KU\left[X\right]={{\int_{ -\infty }^{\infty }{f\left(x\right)\,
 \left(x-E\left[X\right]\right)^4\;dx}}\over{D\left[X\right]^4}}-3$$
@end tex
If @math{X} is gaussian, @math{KU[X]=0}. In fact, both skewness and kurtosis are shape parameters used to measure the non--gaussianity of a distribution.

If the random variable @math{X} is discrete, the density, or @var{probability}, function @math{f(x)} takes positive values within certain countable set of numbers @math{x_i}, and zero elsewhere. In this case, the distribution function is
@ifnottex
@example
                       ====
                       \
                F(x) =  >    f(x )
                       /        i
                       ====
                      x <= x
                       i
@end example
@end ifnottex
@tex
$$F\left(x\right)=\sum_{x_{i}\leq x}{f\left(x_{i}\right)}$$
@end tex

The mean, variance, standard deviation, skewness coefficient and kurtosis coefficient take the form
@ifnottex
@example
                       ====
                       \
                E[X] =  >  x  f(x ) ,
                       /    i    i
                       ====
                        x 
                         i
@end example
@end ifnottex
@tex
$$E\left[X\right]=\sum_{x_{i}}{x_{i}f\left(x_{i}\right)},$$
@end tex

@ifnottex
@example
                ====
                \                     2
        V[X] =   >    f(x ) (x - E[X])  ,
                /        i    i
                ====
                 x
                  i
@end example
@end ifnottex
@tex
$$V\left[X\right]=\sum_{x_{i}}{f\left(x_{i}\right)\left(x_{i}-E\left[X\right]\right)^2},$$
@end tex

@ifnottex
@example
               D[X] = sqrt(V[X]),
@end example
@end ifnottex
@tex
$$D\left[X\right]=\sqrt{V\left[X\right]},$$
@end tex

@ifnottex
@example
                     ====
              1      \                     3
  SK[X] =  -------    >    f(x ) (x - E[X])  
           D[X]^3    /        i    i
                     ====
                      x
                       i
@end example
@end ifnottex
@tex
$$SK\left[X\right]={{\sum_{x_{i}}{f\left(x\right)\,
 \left(x-E\left[X\right]\right)^3\;dx}}\over{D\left[X\right]^3}}$$
@end tex
and
@ifnottex
@example
                     ====
              1      \                     4
  KU[X] =  -------    >    f(x ) (x - E[X])   - 3 ,
           D[X]^4    /        i    i
                     ====
                      x
                       i
@end example
@end ifnottex
@tex
$$KU\left[X\right]={{\sum_{x_{i}}{f\left(x\right)\,
 \left(x-E\left[X\right]\right)^4\;dx}}\over{D\left[X\right]^4}}-3,$$
@end tex
respectively.

There is a naming convention in package @code{distrib}. Every function name has two parts, the first one makes reference to the function or parameter we want to calculate,
@example
Functions:
   Density function            (pdf_*)
   Distribution function       (cdf_*)
   Quantile                    (quantile_*)
   Mean                        (mean_*)
   Variance                    (var_*)
   Standard deviation          (std_*)
   Skewness coefficient        (skewness_*)
   Kurtosis coefficient        (kurtosis_*)
   Random variate              (random_*)
@end example

The second part is an explicit reference to the probabilistic model,
@example
Continuous distributions:
   Normal              (*normal)
   Student             (*student_t)
   Chi^2               (*chi2)
   Noncentral Chi^2    (*noncentral_chi2)
   F                   (*f)
   Exponential         (*exp)
   Lognormal           (*lognormal)
   Gamma               (*gamma)
   Beta                (*beta)
   Continuous uniform  (*continuous_uniform)
   Logistic            (*logistic)
   Pareto              (*pareto)
   Weibull             (*weibull)
   Rayleigh            (*rayleigh)
   Laplace             (*laplace)
   Cauchy              (*cauchy)
   Gumbel              (*gumbel)

Discrete distributions:
   Binomial             (*binomial)
   Poisson              (*poisson)
   Bernoulli            (*bernoulli)
   Geometric            (*geometric)
   Discrete uniform     (*discrete_uniform)
   hypergeometric       (*hypergeometric)
   Negative binomial    (*negative_binomial)
   Finite discrete      (*general_finite_discrete)
@end example

For example, @code{pdf_student_t(x,n)} is the density function of the Student distribution with @var{n} degrees of freedom, @code{std_pareto(a,b)} is the standard deviation of the Pareto distribution with parameters @var{a} and @var{b} and @code{kurtosis_poisson(m)} is the kurtosis coefficient of the Poisson distribution with mean @var{m}.


In order to make use of package @code{distrib} you need first to load it by typing
@example
(%i1) load("distrib")$
@end example

For comments, bugs or suggestions, please contact the author at @var{'riotorto AT yahoo DOT com'}.

@opencatbox
@category{Statistical functions}
@category{Share packages}
@category{Package distrib}
@closecatbox




@node Functions and Variables for continuous distributions, Functions and Variables for discrete distributions, Introduction to distrib, distrib-pkg
@section Functions and Variables for continuous distributions


@anchor{pdf_normal}
@deffn {Function} pdf_normal (@var{x},@var{m},@var{s})
Returns the value at @var{x} of the density function of a @math{Normal(m,s)} random variable, with @math{s>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_normal}
@deffn {Function} cdf_normal (@var{x},@var{m},@var{s})
Returns the value at @var{x} of the distribution function of a @math{Normal(m,s)} random variable, with @math{s>0}. This function is defined in terms of Maxima's built-in error function @code{erf}.

@c ===beg===
@c load ("distrib")$
@c cdf_normal(x,m,s);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_normal(x,m,s);
                                    x - m
                              erf(---------)
                                  sqrt(2) s    1
(%o2)                         -------------- + -
                                    2          2
@end example

See also @mrefdot{erf}

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_normal}
@deffn {Function} quantile_normal (@var{q},@var{m},@var{s})
Returns the @var{q}-quantile of a @math{Normal(m,s)} random variable, with @math{s>0}; in other words, this is the inverse of @mrefdot{cdf_normal} Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@c ===beg===
@c load ("distrib")$
@c quantile_normal(95/100,0,1);
@c float(%);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) quantile_normal(95/100,0,1);
                                      9
(%o2)             sqrt(2) inverse_erf(--)
                                      10
(%i3) float(%);
(%o3)               1.644853626951472
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_normal}
@deffn {Function} mean_normal (@var{m},@var{s})
Returns the mean of a @math{Normal(m,s)} random variable, with @math{s>0}, namely @var{m}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_normal}
@deffn {Function} var_normal (@var{m},@var{s})
Returns the variance of a @math{Normal(m,s)} random variable, with @math{s>0}, namely @var{s^2}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn

@anchor{std_normal}
@deffn {Function} std_normal (@var{m},@var{s})
Returns the standard deviation of a @math{Normal(m,s)} random variable, with @math{s>0}, namely @var{s}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_normal}
@deffn {Function} skewness_normal (@var{m},@var{s})
Returns the skewness coefficient of a @math{Normal(m,s)} random variable, with @math{s>0}, which is always equal to 0. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_normal}
@deffn {Function} kurtosis_normal (@var{m},@var{s})
Returns the kurtosis coefficient of a @math{Normal(m,s)} random variable, with @math{s>0}, which is always equal to 0. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_normal}
@deffn {Function} random_normal (@var{m},@var{s}) @
@fname{random_normal} (@var{m},@var{s},@var{n})

Returns a @math{Normal(m,s)} random variate, with @math{s>0}. Calling @code{random_normal} with a third argument @var{n}, a random sample of size @var{n} will be simulated.

This is an implementation of the Box-Mueller algorithm, as described in Knuth, D.E. (1981) @var{Seminumerical Algorithms. The Art of Computer Programming.} Addison-Wesley.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_student_t}
@deffn {Function} pdf_student_t (@var{x},@var{n})
Returns the value at @var{x} of the density function of a Student random variable @math{t(n)}, with @math{n>0} degrees of freedom. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_student_t}
@deffn {Function} cdf_student_t (@var{x},@var{n})
Returns the value at @var{x} of the distribution function of a Student random variable @math{t(n)}, with @math{n>0} degrees of freedom.

@c ===beg===
@c load ("distrib")$
@c cdf_student_t(1/2, 7/3);
@c float(%);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_student_t(1/2, 7/3);
                                         7  1  28
             beta_incomplete_regularized(-, -, --)
                                         6  2  31
(%o2)    1 - -------------------------------------
                               2
(%i3) float(%);
(%o3)                .6698450596140415
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_student_t}
@deffn {Function} quantile_student_t (@var{q},@var{n})
Returns the @var{q}-quantile of a Student random variable @math{t(n)}, with @math{n>0}; in other words, this is the inverse of @code{cdf_student_t}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_student_t}
@deffn {Function} mean_student_t (@var{n})
Returns the mean of a Student random variable @math{t(n)}, with @math{n>0}, which is always equal to 0. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_student_t}
@deffn {Function} var_student_t (@var{n})
Returns the variance of a Student random variable @math{t(n)}, with @math{n>2}.

@c ===beg===
@c load ("distrib")$
@c var_student_t(n);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) var_student_t(n);
                                n
(%o2)                         -----
                              n - 2
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_student_t}
@deffn {Function} std_student_t (@var{n})
Returns the standard deviation of a Student random variable @math{t(n)}, with @math{n>2}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_student_t}
@deffn {Function} skewness_student_t (@var{n})
Returns the skewness coefficient of a Student random variable @math{t(n)}, with @math{n>3}, which is always equal to 0. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_student_t}
@deffn {Function} kurtosis_student_t (@var{n})
Returns the kurtosis coefficient of a Student random variable @math{t(n)}, with @math{n>4}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_student_t}
@deffn {Function} random_student_t (@var{n}) @
@fname{random_student_t} (@var{n},@var{m})

Returns a Student random variate @math{t(n)}, with @math{n>0}. Calling @code{random_student_t} with a second argument @var{m}, a random sample of size @var{m} will be simulated.

The implemented algorithm is based on the fact that if @var{Z} is a normal random variable @math{N(0,1)} and @math{S^2} is a chi square random variable with @var{n} degrees of freedom, @math{Chi^2(n)}, then
@ifnottex
@example
                           Z
                 X = -------------
                     /   2  \ 1/2
                     |  S   |
                     | ---  |
                     \  n   /
@end example
@end ifnottex
@tex
$$X={{Z}\over{\sqrt{{S^2}\over{n}}}}$$
@end tex
is a Student random variable with @var{n} degrees of freedom, @math{t(n)}.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_noncentral_student_t}
@deffn {Function} pdf_noncentral_student_t (@var{x},@var{n},@var{ncp})
Returns the value at @var{x} of the density function of a noncentral Student random variable @math{nc_t(n,ncp)}, with @math{n>0} degrees of freedom and noncentrality parameter @math{ncp}. To make use of this function, write first @code{load("distrib")}.

Sometimes an extra work is necessary to get the final result.

@c ===beg===
@c load ("distrib")$
@c expand(pdf_noncentral_student_t(3,5,0.1));
@c float(%);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) expand(pdf_noncentral_student_t(3,5,0.1));
@group
                           7/2                         7/2
      0.04296414417400905 5      1.323650307289301e-6 5
(%o2) ------------------------ + -------------------------
         3/2   5/2                       sqrt(%pi)
        2    14    sqrt(%pi)
                                                        7/2
                                   1.94793720435093e-4 5
                                 + ------------------------
                                             %pi
@end group
(%i3) float(%);
(%o3)          .02080593159405669
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_noncentral_student_t}
@deffn {Function} cdf_noncentral_student_t (@var{x},@var{n},@var{ncp})
Returns the value at @var{x} of the distribution function of a noncentral Student random variable @math{nc_t(n,ncp)}, with @math{n>0} degrees of freedom and noncentrality parameter @math{ncp}. This function has no closed form and it is numerically computed.

@c ===beg===
@c load ("distrib")$
@c cdf_noncentral_student_t(-2,5,-5);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_noncentral_student_t(-2,5,-5);
(%o2)          .9952030093319743
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_noncentral_student_t}
@deffn {Function} quantile_noncentral_student_t (@var{q},@var{n},@var{ncp})
Returns the @var{q}-quantile of a noncentral Student random variable @math{nc_t(n,ncp)}, with @math{n>0} degrees of freedom and noncentrality parameter @math{ncp}; in other words, this is the inverse of @code{cdf_noncentral_student_t}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_noncentral_student_t}
@deffn {Function} mean_noncentral_student_t (@var{n},@var{ncp})
Returns the mean of a noncentral Student random variable @math{nc_t(n,ncp)}, with @math{n>1} degrees of freedom and noncentrality parameter @math{ncp}. To make use of this function, write first @code{load("distrib")}.

@c ===beg===
@c load ("distrib")$
@c mean_noncentral_student_t(df,k);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) mean_noncentral_student_t(df,k);
                   df - 1
             gamma(------) sqrt(df) k
                     2
(%o2)        ------------------------
                              df
                sqrt(2) gamma(--)
                              2
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_noncentral_student_t}
@deffn {Function} var_noncentral_student_t (@var{n},@var{ncp})
Returns the variance of a noncentral Student random variable @math{nc_t(n,ncp)}, with @math{n>2} degrees of freedom and noncentrality parameter @math{ncp}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_noncentral_student_t}
@deffn {Function} std_noncentral_student_t (@var{n},@var{ncp})
Returns the standard deviation of a noncentral Student random variable @math{nc_t(n,ncp)}, with @math{n>2} degrees of freedom and noncentrality parameter @math{ncp}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_noncentral_student_t}
@deffn {Function} skewness_noncentral_student_t (@var{n},@var{ncp})
Returns the skewness coefficient of a noncentral Student random variable @math{nc_t(n,ncp)}, with @math{n>3} degrees of freedom and noncentrality parameter @math{ncp}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_noncentral_student_t}
@deffn {Function} kurtosis_noncentral_student_t (@var{n},@var{ncp})
Returns the kurtosis coefficient of a noncentral Student random variable @math{nc_t(n,ncp)}, with @math{n>4} degrees of freedom and noncentrality parameter @math{ncp}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_noncentral_student_t}
@deffn {Function} random_noncentral_student_t (@var{n},@var{ncp}) @
@fname{random_noncentral_student_t} (@var{n},@var{ncp},@var{m})

Returns a noncentral Student random variate @math{nc_t(n,ncp)}, with @math{n>0}. Calling @code{random_noncentral_student_t} with a third argument @var{m}, a random sample of size @var{m} will be simulated.

The implemented algorithm is based on the fact that if @var{X} is a normal random variable @math{N(ncp,1)} and @math{S^2} is a chi square random variable with @var{n} degrees of freedom, @math{Chi^2(n)}, then
@ifnottex
@example
                           X
                 U = -------------
                     /   2  \ 1/2
                     |  S   |
                     | ---  |
                     \  n   /
@end example
@end ifnottex
@tex
$$U={{X}\over{\sqrt{{S^2}\over{n}}}}$$
@end tex
is a noncentral Student random variable with @var{n} degrees of freedom and noncentrality parameter @math{ncp}, @math{nc_t(n,ncp)}.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_chi2}
@deffn {Function} pdf_chi2 (@var{x},@var{n})
Returns the value at @var{x} of the density function of a Chi-square random variable @math{Chi^2(n)}, with @math{n>0}.
The @math{Chi^2(n)} random variable is equivalent to the @math{Gamma(n/2,2)}.

@c ===beg===
@c load ("distrib")$
@c pdf_chi2(x,n);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) pdf_chi2(x,n);
                         n/2 - 1   - x/2
                        x        %e
(%o2)                   ----------------
                          n/2       n
                         2    gamma(-)
                                    2
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_chi2}
@deffn {Function} cdf_chi2 (@var{x},@var{n})
Returns the value at @var{x} of the distribution function of a Chi-square random variable @math{Chi^2(n)}, with @math{n>0}.

@c ===beg===
@c load ("distrib")$
@c cdf_chi2(3,4);
@c float(%);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_chi2(3,4);
                                               3
(%o2)      1 - gamma_incomplete_regularized(2, -)
                                               2
(%i3) float(%);
(%o3)               .4421745996289256
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_chi2}
@deffn {Function} quantile_chi2 (@var{q},@var{n})
Returns the @var{q}-quantile of a Chi-square random variable @math{Chi^2(n)}, with @math{n>0}; in other words, this is the inverse of @code{cdf_chi2}. Argument @var{q} must be an element of @math{[0,1]}.

This function has no closed form and it is numerically computed.

@c ===beg===
@c load ("distrib")$
@c quantile_chi2(0.99,9);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) quantile_chi2(0.99,9);
(%o2)                   21.66599433346194
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_chi2}
@deffn {Function} mean_chi2 (@var{n})
Returns the mean of a Chi-square random variable @math{Chi^2(n)}, with @math{n>0}.

The @math{Chi^2(n)} random variable is equivalent to the @math{Gamma(n/2,2)}.

@c ===beg===
@c load ("distrib")$
@c mean_chi2(n);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) mean_chi2(n);
(%o2)                           n
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_chi2}
@deffn {Function} var_chi2 (@var{n})
Returns the variance of a Chi-square random variable @math{Chi^2(n)}, with @math{n>0}.

The @math{Chi^2(n)} random variable is equivalent to the @math{Gamma(n/2,2)}.

@c ===beg===
@c load ("distrib")$
@c var_chi2(n);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) var_chi2(n);
(%o2)                          2 n
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_chi2}
@deffn {Function} std_chi2 (@var{n})
Returns the standard deviation of a Chi-square random variable @math{Chi^2(n)}, with @math{n>0}.

The @math{Chi^2(n)} random variable is equivalent to the @math{Gamma(n/2,2)}.

@c ===beg===
@c load ("distrib")$
@c std_chi2(n);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) std_chi2(n);
(%o2)                    sqrt(2) sqrt(n)
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_chi2}
@deffn {Function} skewness_chi2 (@var{n})
Returns the skewness coefficient of a Chi-square random variable @math{Chi^2(n)}, with @math{n>0}.

The @math{Chi^2(n)} random variable is equivalent to the @math{Gamma(n/2,2)}.

@c ===beg===
@c load ("distrib")$
@c skewness_chi2(n);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) skewness_chi2(n);
                                     3/2
                                    2
(%o2)                              -------
                                   sqrt(n)
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_chi2}
@deffn {Function} kurtosis_chi2 (@var{n})
Returns the kurtosis coefficient of a Chi-square random variable @math{Chi^2(n)}, with @math{n>0}.

The @math{Chi^2(n)} random variable is equivalent to the @math{Gamma(n/2,2)}.

@c ===beg===
@c load ("distrib")$
@c kurtosis_chi2(n);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) kurtosis_chi2(n);
                               12
(%o2)                          --
                               n
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_chi2}
@deffn {Function} random_chi2 (@var{n}) @
@fname{random_chi2} (@var{n},@var{m})

Returns a Chi-square random variate @math{Chi^2(n)}, with @math{n>0}. Calling @code{random_chi2} with a second argument @var{m}, a random sample of size @var{m} will be simulated.

The simulation is based on the Ahrens-Cheng algorithm. See @code{random_gamma} for details.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_noncentral_chi2}
@deffn {Function} pdf_noncentral_chi2 (@var{x},@var{n},@var{ncp})
Returns the value at @var{x} of the density function of a noncentral Chi-square random variable @math{nc_Chi^2(n,ncp)}, with @math{n>0} and noncentrality parameter @math{ncp>=0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_noncentral_chi2}
@deffn {Function} cdf_noncentral_chi2 (@var{x},@var{n},@var{ncp})
Returns the value at @var{x} of the distribution function of a noncentral Chi-square random variable @math{nc_Chi^2(n,ncp)}, with @math{n>0} and noncentrality parameter @math{ncp>=0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_noncentral_chi2}
@deffn {Function} quantile_noncentral_chi2 (@var{q},@var{n},@var{ncp})
Returns the @var{q}-quantile of a noncentral Chi-square random variable @math{nc_Chi^2(n,ncp)}, with @math{n>0} and noncentrality parameter @math{ncp>=0}; in other words, this is the inverse of @code{cdf_noncentral_chi2}. Argument @var{q} must be an element of @math{[0,1]}.

This function has no closed form and it is numerically computed.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_noncentral_chi2}
@deffn {Function} mean_noncentral_chi2 (@var{n},@var{ncp})
Returns the mean of a noncentral Chi-square random variable @math{nc_Chi^2(n,ncp)}, with @math{n>0} and noncentrality parameter @math{ncp>=0}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_noncentral_chi2}
@deffn {Function} var_noncentral_chi2 (@var{n},@var{ncp})
Returns the variance of a noncentral Chi-square random variable @math{nc_Chi^2(n,ncp)}, with @math{n>0} and noncentrality parameter @math{ncp>=0}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_noncentral_chi2}
@deffn {Function} std_noncentral_chi2 (@var{n},@var{ncp})
Returns the standard deviation of a noncentral Chi-square random variable @math{nc_Chi^2(n,ncp)}, with @math{n>0} and noncentrality parameter @math{ncp>=0}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_noncentral_chi2}
@deffn {Function} skewness_noncentral_chi2 (@var{n},@var{ncp})
Returns the skewness coefficient of a noncentral Chi-square random variable @math{nc_Chi^2(n,ncp)}, with @math{n>0} and noncentrality parameter @math{ncp>=0}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_noncentral_chi2}
@deffn {Function} kurtosis_noncentral_chi2 (@var{n},@var{ncp})
Returns the kurtosis coefficient of a noncentral Chi-square random variable @math{nc_Chi^2(n,ncp)}, with @math{n>0} and noncentrality parameter @math{ncp>=0}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_noncentral_chi2}
@deffn {Function} random_noncentral_chi2 (@var{n},@var{ncp}) @
@fname{random_noncentral_chi2} (@var{n},@var{ncp},@var{m})

Returns a noncentral Chi-square random variate @math{nc_Chi^2(n,ncp)}, with @math{n>0} and noncentrality parameter @math{ncp>=0}. Calling @code{random_noncentral_chi2} with a third argument @var{m}, a random sample of size @var{m} will be simulated.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn



@anchor{pdf_f}
@deffn {Function} pdf_f (@var{x},@var{m},@var{n})
Returns the value at @var{x} of the density function of a F random variable @math{F(m,n)}, with @math{m,n>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_f}
@deffn {Function} cdf_f (@var{x},@var{m},@var{n})
Returns the value at @var{x} of the distribution function of a F random variable @math{F(m,n)}, with @math{m,n>0}.

@c ===beg===
@c load ("distrib")$
@c cdf_f(2,3,9/4);
@c float(%);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_f(2,3,9/4);
                                         9  3  3
(%o2)    1 - beta_incomplete_regularized(-, -, --)
                                         8  2  11
(%i3) float(%);
(%o3)                 0.66756728179008
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_f}
@deffn {Function} quantile_f (@var{q},@var{m},@var{n})
Returns the @var{q}-quantile of a F random variable @math{F(m,n)}, with @math{m,n>0}; in other words, this is the inverse of @code{cdf_f}. Argument @var{q} must be an element of @math{[0,1]}.

@c ===beg===
@c load ("distrib")$
@c quantile_f(2/5,sqrt(3),5);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) quantile_f(2/5,sqrt(3),5);
(%o2)                   0.518947838573693
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_f}
@deffn {Function} mean_f (@var{m},@var{n})
Returns the mean of a F random variable @math{F(m,n)}, with @math{m>0, n>2}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_f}
@deffn {Function} var_f (@var{m},@var{n})
Returns the variance of a F random variable @math{F(m,n)}, with @math{m>0, n>4}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_f}
@deffn {Function} std_f (@var{m},@var{n})
Returns the standard deviation of a F random variable @math{F(m,n)}, with @math{m>0, n>4}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_f}
@deffn {Function} skewness_f (@var{m},@var{n})
Returns the skewness coefficient of a F random variable @math{F(m,n)}, with @math{m>0, n>6}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_f}
@deffn {Function} kurtosis_f (@var{m},@var{n})
Returns the kurtosis coefficient of a F random variable @math{F(m,n)}, with @math{m>0, n>8}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_f}
@deffn {Function} random_f (@var{m},@var{n}) @
@fname{random_f} (@var{m},@var{n},@var{k})

Returns a F random variate @math{F(m,n)}, with @math{m,n>0}. Calling @code{random_f} with a third argument @var{k}, a random sample of size @var{k} will be simulated.

The simulation algorithm is based on the fact that if @var{X} is a @math{Chi^2(m)} random variable and @math{Y} is a @math{Chi^2(n)} random variable, then
@ifnottex
@example
                        n X
                    F = ---
                        m Y
@end example
@end ifnottex
@tex
$$F={{n X}\over{m Y}}$$
@end tex
is a F random variable with @var{m} and @var{n} degrees of freedom, @math{F(m,n)}.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_exp}
@deffn {Function} pdf_exp (@var{x},@var{m})
Returns the value at @var{x} of the density function of an @math{Exponential(m)} random variable, with @math{m>0}.

The @math{Exponential(m)} random variable is equivalent to the @math{Weibull(1,1/m)}.

@c ===beg===
@c load ("distrib")$
@c pdf_exp(x,m);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) pdf_exp(x,m);
                                - m x
(%o2)                       m %e
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_exp}
@deffn {Function} cdf_exp (@var{x},@var{m})
Returns the value at @var{x} of the distribution function of an @math{Exponential(m)} random variable, with @math{m>0}.

The @math{Exponential(m)} random variable is equivalent to the @math{Weibull(1,1/m)}.

@c ===beg===
@c load ("distrib")$
@c cdf_exp(x,m);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_exp(x,m);
                                 - m x
(%o2)                      1 - %e
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_exp}
@deffn {Function} quantile_exp (@var{q},@var{m})
Returns the @var{q}-quantile of an @math{Exponential(m)} random variable, with @math{m>0}; in other words, this is the inverse of @code{cdf_exp}. Argument @var{q} must be an element of @math{[0,1]}.

The @math{Exponential(m)} random variable is equivalent to the @math{Weibull(1,1/m)}.

@c ===beg===
@c load ("distrib")$
@c quantile_exp(0.56,5);
@c quantile_exp(0.56,m);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) quantile_exp(0.56,5);
(%o2)                   .1641961104139661
(%i3) quantile_exp(0.56,m);
                             0.8209805520698303
(%o3)                        ------------------
                                     m
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_exp}
@deffn {Function} mean_exp (@var{m})
Returns the mean of an @math{Exponential(m)} random variable, with @math{m>0}.

The @math{Exponential(m)} random variable is equivalent to the @math{Weibull(1,1/m)}.

@c ===beg===
@c load ("distrib")$
@c mean_exp(m);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) mean_exp(m);
                                1
(%o2)                           -
                                m
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_exp}
@deffn {Function} var_exp (@var{m})
Returns the variance of an @math{Exponential(m)} random variable, with @math{m>0}.

The @math{Exponential(m)} random variable is equivalent to the @math{Weibull(1,1/m)}.

@c ===beg===
@c load ("distrib")$
@c var_exp(m);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) var_exp(m);
                               1
(%o2)                          --
                                2
                               m
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_exp}
@deffn {Function} std_exp (@var{m})
Returns the standard deviation of an @math{Exponential(m)} random variable, with @math{m>0}.

The @math{Exponential(m)} random variable is equivalent to the @math{Weibull(1,1/m)}.

@c ===beg===
@c load ("distrib")$
@c std_exp(m);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) std_exp(m);
                                1
(%o2)                           -
                                m
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_exp}
@deffn {Function} skewness_exp (@var{m})
Returns the skewness coefficient of an @math{Exponential(m)} random variable, with @math{m>0}.

The @math{Exponential(m)} random variable is equivalent to the @math{Weibull(1,1/m)}.

@c ===beg===
@c load ("distrib")$
@c skewness_exp(m);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) skewness_exp(m);
(%o2)                           2
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_exp}
@deffn {Function} kurtosis_exp (@var{m})
Returns the kurtosis coefficient of an @math{Exponential(m)} random variable, with @math{m>0}.

The @math{Exponential(m)} random variable is equivalent to the @math{Weibull(1,1/m)}.

@c ===beg===
@c load ("distrib")$
@c kurtosis_exp(m);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) kurtosis_exp(m);
(%o3)                           6
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_exp}
@deffn {Function} random_exp (@var{m}) @
@fname{random_exp} (@var{m},@var{k})

Returns an @math{Exponential(m)} random variate, with @math{m>0}. Calling @code{random_exp} with a second argument @var{k}, a random sample of size @var{k} will be simulated.

The simulation algorithm is based on the general inverse method.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_lognormal}
@deffn {Function} pdf_lognormal (@var{x},@var{m},@var{s})
Returns the value at @var{x} of the density function of a @math{Lognormal(m,s)} random variable, with @math{s>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_lognormal}
@deffn {Function} cdf_lognormal (@var{x},@var{m},@var{s})
Returns the value at @var{x} of the distribution function of a @math{Lognormal(m,s)} random variable, with @math{s>0}. This function is defined in terms of Maxima's built-in error function @code{erf}.

@c ===beg===
@c load ("distrib")$
@c cdf_lognormal(x,m,s);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_lognormal(x,m,s);
@group
                           log(x) - m
                       erf(----------)
                           sqrt(2) s     1
(%o2)                  --------------- + -
                              2          2
@end group
@end example

See also @mrefdot{erf}

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_lognormal}
@deffn {Function} quantile_lognormal (@var{q},@var{m},@var{s})
Returns the @var{q}-quantile of a @math{Lognormal(m,s)} random variable, with @math{s>0}; in other words, this is the inverse of @code{cdf_lognormal}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@c ===beg===
@c load ("distrib")$
@c quantile_lognormal(95/100,0,1);
@c float(%);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) quantile_lognormal(95/100,0,1);
                  sqrt(2) inverse_erf(9/10)
(%o2)           %e
(%i3) float(%);
(%o3)               5.180251602233015
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_lognormal}
@deffn {Function} mean_lognormal (@var{m},@var{s})
Returns the mean of a @math{Lognormal(m,s)} random variable, with @math{s>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_lognormal}
@deffn {Function} var_lognormal (@var{m},@var{s})
Returns the variance of a @math{Lognormal(m,s)} random variable, with @math{s>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn

@anchor{std_lognormal}
@deffn {Function} std_lognormal (@var{m},@var{s})
Returns the standard deviation of a @math{Lognormal(m,s)} random variable, with @math{s>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_lognormal}
@deffn {Function} skewness_lognormal (@var{m},@var{s})
Returns the skewness coefficient of a @math{Lognormal(m,s)} random variable, with @math{s>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_lognormal}
@deffn {Function} kurtosis_lognormal (@var{m},@var{s})
Returns the kurtosis coefficient of a @math{Lognormal(m,s)} random variable, with @math{s>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_lognormal}
@deffn {Function} random_lognormal (@var{m},@var{s}) @
@fname{random_lognormal} (@var{m},@var{s},@var{n})

Returns a @math{Lognormal(m,s)} random variate, with @math{s>0}. Calling @code{random_lognormal} with a third argument @var{n}, a random sample of size @var{n} will be simulated.

Log-normal variates are simulated by means of random normal variates. See @code{random_normal} for details.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_gamma}
@deffn {Function} pdf_gamma (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the density function of a @math{Gamma(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_gamma}
@deffn {Function} cdf_gamma (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the distribution function of a @math{Gamma(a,b)} random variable, with @math{a,b>0}. 

@c ===beg===
@c load ("distrib")$
@c cdf_gamma(3,5,21);
@c float(%);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_gamma(3,5,21);
                                              1
(%o2)     1 - gamma_incomplete_regularized(5, -)
                                              7
(%i3) float(%);
(%o3)              4.402663157376807E-7
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_gamma}
@deffn {Function} quantile_gamma (@var{q},@var{a},@var{b})
Returns the @var{q}-quantile of a @math{Gamma(a,b)} random variable, with @math{a,b>0}; in other words, this is the inverse of @code{cdf_gamma}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_gamma}
@deffn {Function} mean_gamma (@var{a},@var{b})
Returns the mean of a @math{Gamma(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_gamma}
@deffn {Function} var_gamma (@var{a},@var{b})
Returns the variance of a @math{Gamma(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn

@anchor{std_gamma}
@deffn {Function} std_gamma (@var{a},@var{b})
Returns the standard deviation of a @math{Gamma(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_gamma}
@deffn {Function} skewness_gamma (@var{a},@var{b})
Returns the skewness coefficient of a @math{Gamma(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_gamma}
@deffn {Function} kurtosis_gamma (@var{a},@var{b})
Returns the kurtosis coefficient of a @math{Gamma(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_gamma}
@deffn {Function} random_gamma (@var{a},@var{b}) @
@fname{random_gamma} (@var{a},@var{b},@var{n})

Returns a @math{Gamma(a,b)} random variate, with @math{a,b>0}. Calling @code{random_gamma} with a third argument @var{n}, a random sample of size @var{n} will be simulated.

The implemented algorithm is a combinantion of two procedures, depending on the value of parameter @var{a}:

For @math{a>=1}, Cheng, R.C.H. and Feast, G.M. (1979). @var{Some simple gamma variate generators}. Appl. Stat., 28, 3, 290-295.

For @math{0<a<1}, Ahrens, J.H. and Dieter, U. (1974). @var{Computer methods for sampling from gamma, beta, poisson and binomial cdf_tributions}. Computing, 12, 223-246.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_beta}
@deffn {Function} pdf_beta (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the density function of a @math{Beta(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn



@anchor{cdf_beta}
@deffn {Function} cdf_beta (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the distribution function of a @math{Beta(a,b)} random variable, with @math{a,b>0}.

@c ===beg===
@c load ("distrib")$
@c cdf_beta(1/3,15,2);
@c float(%);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_beta(1/3,15,2);
                             11
(%o2)                     --------
                          14348907
(%i3) float(%);
(%o3)              7.666089131388195E-7
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_beta}
@deffn {Function} quantile_beta (@var{q},@var{a},@var{b})
Returns the @var{q}-quantile of a @math{Beta(a,b)} random variable, with @math{a,b>0}; in other words, this is the inverse of @code{cdf_beta}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_beta}
@deffn {Function} mean_beta (@var{a},@var{b})
Returns the mean of a @math{Beta(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_beta}
@deffn {Function} var_beta (@var{a},@var{b})
Returns the variance of a @math{Beta(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn

@anchor{std_beta}
@deffn {Function} std_beta (@var{a},@var{b})
Returns the standard deviation of a @math{Beta(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_beta}
@deffn {Function} skewness_beta (@var{a},@var{b})
Returns the skewness coefficient of a @math{Beta(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_beta}
@deffn {Function} kurtosis_beta (@var{a},@var{b})
Returns the kurtosis coefficient of a @math{Beta(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_beta}
@deffn {Function} random_beta (@var{a},@var{b}) @
@fname{random_beta} (@var{a},@var{b},@var{n})

Returns a @math{Beta(a,b)} random variate, with @math{a,b>0}. Calling @code{random_beta} with a third argument @var{n}, a random sample of size @var{n} will be simulated.

The implemented algorithm is defined in Cheng, R.C.H.  (1978). @var{Generating Beta Variates with Nonintegral Shape Parameters}. Communications of the ACM, 21:317-322

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn

@anchor{pdf_continuous_uniform}
@deffn {Function} pdf_continuous_uniform (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the density function of a @math{Continuous Uniform(a,b)} random variable, with @math{a<b}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_continuous_uniform}
@deffn {Function} cdf_continuous_uniform (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the distribution function of a @math{Continuous Uniform(a,b)} random variable, with @math{a<b}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_continuous_uniform}
@deffn {Function} quantile_continuous_uniform (@var{q},@var{a},@var{b})
Returns the @var{q}-quantile of a @math{Continuous Uniform(a,b)} random variable, with @math{a<b}; in other words, this is the inverse of @code{cdf_continuous_uniform}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_continuous_uniform}
@deffn {Function} mean_continuous_uniform (@var{a},@var{b})
Returns the mean of a @math{Continuous Uniform(a,b)} random variable, with @math{a<b}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_continuous_uniform}
@deffn {Function} var_continuous_uniform (@var{a},@var{b})
Returns the variance of a @math{Continuous Uniform(a,b)} random variable, with @math{a<b}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn

@anchor{std_continuous_uniform}
@deffn {Function} std_continuous_uniform (@var{a},@var{b})
Returns the standard deviation of a @math{Continuous Uniform(a,b)} random variable, with @math{a<b}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_continuous_uniform}
@deffn {Function} skewness_continuous_uniform (@var{a},@var{b})
Returns the skewness coefficient of a @math{Continuous Uniform(a,b)} random variable, with @math{a<b}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_continuous_uniform}
@deffn {Function} kurtosis_continuous_uniform (@var{a},@var{b})
Returns the kurtosis coefficient of a @math{Continuous Uniform(a,b)} random variable, with @math{a<b}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_continuous_uniform}
@deffn {Function} random_continuous_uniform (@var{a},@var{b}) @
@fname{random_continuous_uniform} (@var{a},@var{b},@var{n})

Returns a @math{Continuous Uniform(a,b)} random variate, with @math{a<b}. Calling @code{random_continuous_uniform} with a third argument @var{n}, a random sample of size @var{n} will be simulated.

This is a direct application of the @code{random} built-in Maxima function.

See also @mrefdot{random} To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_logistic}
@deffn {Function} pdf_logistic (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the density function of a @math{Logistic(a,b)} random variable , with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_logistic}
@deffn {Function} cdf_logistic (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the distribution function of a @math{Logistic(a,b)} random variable , with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_logistic}
@deffn {Function} quantile_logistic (@var{q},@var{a},@var{b})
Returns the @var{q}-quantile of a @math{Logistic(a,b)} random variable , with @math{b>0}; in other words, this is the inverse of @code{cdf_logistic}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_logistic}
@deffn {Function} mean_logistic (@var{a},@var{b})
Returns the mean of a @math{Logistic(a,b)} random variable , with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_logistic}
@deffn {Function} var_logistic (@var{a},@var{b})
Returns the variance of a @math{Logistic(a,b)} random variable , with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_logistic}
@deffn {Function} std_logistic (@var{a},@var{b})
Returns the standard deviation of a @math{Logistic(a,b)} random variable , with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_logistic}
@deffn {Function} skewness_logistic (@var{a},@var{b})
Returns the skewness coefficient of a @math{Logistic(a,b)} random variable , with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_logistic}
@deffn {Function} kurtosis_logistic (@var{a},@var{b})
Returns the kurtosis coefficient of a @math{Logistic(a,b)} random variable , with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_logistic}
@deffn {Function} random_logistic (@var{a},@var{b}) @
@fname{random_logistic} (@var{a},@var{b},@var{n})

Returns a @math{Logistic(a,b)} random variate, with @math{b>0}. Calling @code{random_logistic} with a third argument @var{n}, a random sample of size @var{n} will be simulated.

The implemented algorithm is based on the general inverse method.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_pareto}
@deffn {Function} pdf_pareto (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the density function of a @math{Pareto(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_pareto}
@deffn {Function} cdf_pareto (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the distribution function of a @math{Pareto(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_pareto}
@deffn {Function} quantile_pareto (@var{q},@var{a},@var{b})
Returns the @var{q}-quantile of a @math{Pareto(a,b)} random variable, with @math{a,b>0}; in other words, this is the inverse of @code{cdf_pareto}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_pareto}
@deffn {Function} mean_pareto (@var{a},@var{b})
Returns the mean of a @math{Pareto(a,b)} random variable, with @math{a>1,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_pareto}
@deffn {Function} var_pareto (@var{a},@var{b})
Returns the variance of a @math{Pareto(a,b)} random variable, with @math{a>2,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn

@anchor{std_pareto}
@deffn {Function} std_pareto (@var{a},@var{b})
Returns the standard deviation of a @math{Pareto(a,b)} random variable, with @math{a>2,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn



@anchor{skewness_pareto}
@deffn {Function} skewness_pareto (@var{a},@var{b})
Returns the skewness coefficient of a @math{Pareto(a,b)} random variable, with @math{a>3,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_pareto}
@deffn {Function} kurtosis_pareto (@var{a},@var{b})
Returns the kurtosis coefficient of a @math{Pareto(a,b)} random variable, with @math{a>4,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_pareto}
@deffn {Function} random_pareto (@var{a},@var{b}) @
@fname{random_pareto} (@var{a},@var{b},@var{n})

Returns a @math{Pareto(a,b)} random variate, with @math{a>0,b>0}. Calling @code{random_pareto} with a third argument @var{n}, a random sample of size @var{n} will be simulated.

The implemented algorithm is based on the general inverse method.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_weibull}
@deffn {Function} pdf_weibull (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the density function of a @math{Weibull(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_weibull}
@deffn {Function} cdf_weibull (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the distribution function of a @math{Weibull(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_weibull}
@deffn {Function} quantile_weibull (@var{q},@var{a},@var{b})
Returns the @var{q}-quantile of a @math{Weibull(a,b)} random variable, with @math{a,b>0}; in other words, this is the inverse of @code{cdf_weibull}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_weibull}
@deffn {Function} mean_weibull (@var{a},@var{b})
Returns the mean of a @math{Weibull(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_weibull}
@deffn {Function} var_weibull (@var{a},@var{b})
Returns the variance of a @math{Weibull(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn

@anchor{std_weibull}
@deffn {Function} std_weibull (@var{a},@var{b})
Returns the standard deviation of a @math{Weibull(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn



@anchor{skewness_weibull}
@deffn {Function} skewness_weibull (@var{a},@var{b})
Returns the skewness coefficient of a @math{Weibull(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_weibull}
@deffn {Function} kurtosis_weibull (@var{a},@var{b})
Returns the kurtosis coefficient of a @math{Weibull(a,b)} random variable, with @math{a,b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_weibull}
@deffn {Function} random_weibull (@var{a},@var{b}) @
@fname{random_weibull} (@var{a},@var{b},@var{n})

Returns a @math{Weibull(a,b)} random variate, with @math{a,b>0}. Calling @code{random_weibull} with a third argument @var{n}, a random sample of size @var{n} will be simulated.

The implemented algorithm is based on the general inverse method.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn



@anchor{pdf_rayleigh}
@deffn {Function} pdf_rayleigh (@var{x},@var{b})
Returns the value at @var{x} of the density function of a @math{Rayleigh(b)} random variable, with @math{b>0}.

The @math{Rayleigh(b)} random variable is equivalent to the @math{Weibull(2,1/b)}.

@c ===beg===
@c load ("distrib")$
@c pdf_rayleigh(x,b);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) pdf_rayleigh(x,b);
                                    2  2
                           2     - b  x
(%o2)                   2 b  x %e
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_rayleigh}
@deffn {Function} cdf_rayleigh (@var{x},@var{b})
Returns the value at @var{x} of the distribution function of a @math{Rayleigh(b)} random variable, with @math{b>0}.

The @math{Rayleigh(b)} random variable is equivalent to the @math{Weibull(2,1/b)}.

@c ===beg===
@c load ("distrib")$
@c cdf_rayleigh(x,b);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_rayleigh(x,b);
                                   2  2
                                - b  x
(%o2)                     1 - %e
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_rayleigh}
@deffn {Function} quantile_rayleigh (@var{q},@var{b})
Returns the @var{q}-quantile of a @math{Rayleigh(b)} random variable, with @math{b>0}; in other words, this is the inverse of @code{cdf_rayleigh}. Argument @var{q} must be an element of @math{[0,1]}.

The @math{Rayleigh(b)} random variable is equivalent to the @math{Weibull(2,1/b)}.

@c ===beg===
@c load ("distrib")$
@c quantile_rayleigh(0.99,b);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) quantile_rayleigh(0.99,b);
                        2.145966026289347
(%o2)                   -----------------
                                b
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_rayleigh}
@deffn {Function} mean_rayleigh (@var{b})
Returns the mean of a @math{Rayleigh(b)} random variable, with @math{b>0}.

The @math{Rayleigh(b)} random variable is equivalent to the @math{Weibull(2,1/b)}.

@c ===beg===
@c load ("distrib")$
@c mean_rayleigh(b);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) mean_rayleigh(b);
                            sqrt(%pi)
(%o2)                       ---------
                               2 b
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_rayleigh}
@deffn {Function} var_rayleigh (@var{b})
Returns the variance of a @math{Rayleigh(b)} random variable, with @math{b>0}.

The @math{Rayleigh(b)} random variable is equivalent to the @math{Weibull(2,1/b)}.

@c ===beg===
@c load ("distrib")$
@c var_rayleigh(b);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) var_rayleigh(b);
                                 %pi
                             1 - ---
                                  4
(%o2)                        -------
                                2
                               b
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_rayleigh}
@deffn {Function} std_rayleigh (@var{b})
Returns the standard deviation of a @math{Rayleigh(b)} random variable, with @math{b>0}.

The @math{Rayleigh(b)} random variable is equivalent to the @math{Weibull(2,1/b)}.

@c ===beg===
@c load ("distrib")$
@c std_rayleigh(b);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) std_rayleigh(b);
                                   %pi
                          sqrt(1 - ---)
                                    4
(%o2)                     -------------
                                b
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_rayleigh}
@deffn {Function} skewness_rayleigh (@var{b})
Returns the skewness coefficient of a @math{Rayleigh(b)} random variable, with @math{b>0}.

The @math{Rayleigh(b)} random variable is equivalent to the @math{Weibull(2,1/b)}.

@c ===beg===
@c load ("distrib")$
@c skewness_rayleigh(b);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) skewness_rayleigh(b);
                         3/2
                      %pi      3 sqrt(%pi)
                      ------ - -----------
                        4           4
(%o2)                 --------------------
                               %pi 3/2
                          (1 - ---)
                                4
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_rayleigh}
@deffn {Function} kurtosis_rayleigh (@var{b})
Returns the kurtosis coefficient of a @math{Rayleigh(b)} random variable, with @math{b>0}.

The @math{Rayleigh(b)} random variable is equivalent to the @math{Weibull(2,1/b)}.

@c ===beg===
@c load ("distrib")$
@c kurtosis_rayleigh(b);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) kurtosis_rayleigh(b);
                                  2
                             3 %pi
                         2 - ------
                               16
(%o2)                    ---------- - 3
                              %pi 2
                         (1 - ---)
                               4
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_rayleigh}
@deffn {Function} random_rayleigh (@var{b}) @
@fname{random_rayleigh} (@var{b},@var{n})

Returns a @math{Rayleigh(b)} random variate, with @math{b>0}. Calling @code{random_rayleigh} with a second argument @var{n}, a random sample of size @var{n} will be simulated.

The implemented algorithm is based on the general inverse method.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn



@anchor{pdf_laplace}
@deffn {Function} pdf_laplace (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the density function of a @math{Laplace(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_laplace}
@deffn {Function} cdf_laplace (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the distribution function of a @math{Laplace(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_laplace}
@deffn {Function} quantile_laplace (@var{q},@var{a},@var{b})
Returns the @var{q}-quantile of a @math{Laplace(a,b)} random variable, with @math{b>0}; in other words, this is the inverse of @code{cdf_laplace}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_laplace}
@deffn {Function} mean_laplace (@var{a},@var{b})
Returns the mean of a @math{Laplace(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_laplace}
@deffn {Function} var_laplace (@var{a},@var{b})
Returns the variance of a @math{Laplace(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_laplace}
@deffn {Function} std_laplace (@var{a},@var{b})
Returns the standard deviation of a @math{Laplace(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_laplace}
@deffn {Function} skewness_laplace (@var{a},@var{b})
Returns the skewness coefficient of a @math{Laplace(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_laplace}
@deffn {Function} kurtosis_laplace (@var{a},@var{b})
Returns the kurtosis coefficient of a @math{Laplace(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_laplace}
@deffn {Function} random_laplace (@var{a},@var{b}) @
@fname{random_laplace} (@var{a},@var{b},@var{n})

Returns a @math{Laplace(a,b)} random variate, with @math{b>0}. Calling @code{random_laplace} with a third argument @var{n}, a random sample of size @var{n} will be simulated.

The implemented algorithm is based on the general inverse method.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn



@anchor{pdf_cauchy}
@deffn {Function} pdf_cauchy (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the density function of a @math{Cauchy(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_cauchy}
@deffn {Function} cdf_cauchy (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the distribution function of a @math{Cauchy(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_cauchy}
@deffn {Function} quantile_cauchy (@var{q},@var{a},@var{b})
Returns the @var{q}-quantile of a @math{Cauchy(a,b)} random variable, with @math{b>0}; in other words, this is the inverse of @code{cdf_cauchy}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_cauchy}
@deffn {Function} random_cauchy (@var{a},@var{b}) @
@fname{random_cauchy} (@var{a},@var{b},@var{n})

Returns a @math{Cauchy(a,b)} random variate, with @math{b>0}. Calling @code{random_cauchy} with a third argument @var{n}, a random sample of size @var{n} will be simulated.

The implemented algorithm is based on the general inverse method.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn



@anchor{pdf_gumbel}
@deffn {Function} pdf_gumbel (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the density function of a @math{Gumbel(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_gumbel}
@deffn {Function} cdf_gumbel (@var{x},@var{a},@var{b})
Returns the value at @var{x} of the distribution function of a @math{Gumbel(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_gumbel}
@deffn {Function} quantile_gumbel (@var{q},@var{a},@var{b})
Returns the @var{q}-quantile of a @math{Gumbel(a,b)} random variable, with @math{b>0}; in other words, this is the inverse of @code{cdf_gumbel}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_gumbel}
@deffn {Function} mean_gumbel (@var{a},@var{b})
Returns the mean of a @math{Gumbel(a,b)} random variable, with @math{b>0}.

@c ===beg===
@c load ("distrib")$
@c mean_gumbel(a,b);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) mean_gumbel(a,b);
(%o2)                     %gamma b + a
@end example
where symbol @code{%gamma} stands for the Euler-Mascheroni constant. See also @mrefdot{%gamma}

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_gumbel}
@deffn {Function} var_gumbel (@var{a},@var{b})
Returns the variance of a @math{Gumbel(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_gumbel}
@deffn {Function} std_gumbel (@var{a},@var{b})
Returns the standard deviation of a @math{Gumbel(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_gumbel}
@deffn {Function} skewness_gumbel (@var{a},@var{b})
Returns the skewness coefficient of a @math{Gumbel(a,b)} random variable, with @math{b>0}.

@c ===beg===
@c load ("distrib")$
@c skewness_gumbel(a,b);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) skewness_gumbel(a,b);
                                  3/2
                               2 6    zeta(3)
(%o2)                          --------------
                                       3
                                    %pi
@end example
where @code{zeta} stands for the Riemann's zeta function.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_gumbel}
@deffn {Function} kurtosis_gumbel (@var{a},@var{b})
Returns the kurtosis coefficient of a @math{Gumbel(a,b)} random variable, with @math{b>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_gumbel}
@deffn {Function} random_gumbel (@var{a},@var{b}) @
@fname{random_gumbel} (@var{a},@var{b},@var{n})

Returns a @math{Gumbel(a,b)} random variate, with @math{b>0}. Calling @code{random_gumbel} with a third argument @var{n}, a random sample of size @var{n} will be simulated.

The implemented algorithm is based on the general inverse method.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@node Functions and Variables for discrete distributions,  , Functions and Variables for continuous distributions, distrib-pkg
@section Functions and Variables for discrete distributions


@anchor{pdf_general_finite_discrete}
@deffn {Function} pdf_general_finite_discrete (@var{x},@var{v})
Returns the value at @var{x} of the probability function of a general finite discrete random variable, with vector probabilities @math{v}, such that @code{Pr(X=i) = v_i}. Vector @math{v} can be a list of nonnegative expressions, whose components will be normalized to get a vector of probabilities. To make use of this function, write first @code{load("distrib")}.

@c ===beg===
@c load ("distrib")$
@c pdf_general_finite_discrete(2, [1/7, 4/7, 2/7]);
@c pdf_general_finite_discrete(2, [1, 4, 2]);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) pdf_general_finite_discrete(2, [1/7, 4/7, 2/7]);
                                4
(%o2)                           -
                                7
(%i3) pdf_general_finite_discrete(2, [1, 4, 2]);
                                4
(%o3)                           -
                                7
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_general_finite_discrete}
@deffn {Function} cdf_general_finite_discrete (@var{x},@var{v})
Returns the value at @var{x} of the distribution function of a general finite discrete random variable, with vector probabilities @math{v}.

See @code{pdf_general_finite_discrete} for more details.

@c ===beg===
@c load ("distrib")$
@c cdf_general_finite_discrete(2, [1/7, 4/7, 2/7]);
@c cdf_general_finite_discrete(2, [1, 4, 2]);
@c cdf_general_finite_discrete(2+1/2, [1, 4, 2]);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_general_finite_discrete(2, [1/7, 4/7, 2/7]);
                                5
(%o2)                           -
                                7
(%i3) cdf_general_finite_discrete(2, [1, 4, 2]);
                                5
(%o3)                           -
                                7
(%i4) cdf_general_finite_discrete(2+1/2, [1, 4, 2]);
                                5
(%o4)                           -
                                7
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_general_finite_discrete}
@deffn {Function} quantile_general_finite_discrete (@var{q},@var{v})
Returns the @var{q}-quantile of a general finite discrete random variable, with vector probabilities @math{v}.

See @code{pdf_general_finite_discrete} for more details.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_general_finite_discrete}
@deffn {Function} mean_general_finite_discrete (@var{v})
Returns the mean of a general finite discrete random variable, with vector probabilities @math{v}.

See @code{pdf_general_finite_discrete} for more details.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_general_finite_discrete}
@deffn {Function} var_general_finite_discrete (@var{v})
Returns the variance of a general finite discrete random variable, with vector probabilities @math{v}.

See @code{pdf_general_finite_discrete} for more details.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_general_finite_discrete}
@deffn {Function} std_general_finite_discrete (@var{v})
Returns the standard deviation of a general finite discrete random variable, with vector probabilities @math{v}.

See @code{pdf_general_finite_discrete} for more details.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_general_finite_discrete}
@deffn {Function} skewness_general_finite_discrete (@var{v})
Returns the skewness coefficient of a general finite discrete random variable, with vector probabilities @math{v}.

See @code{pdf_general_finite_discrete} for more details.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_general_finite_discrete}
@deffn {Function} kurtosis_general_finite_discrete (@var{v})
Returns the kurtosis coefficient of a general finite discrete random variable, with vector probabilities @math{v}.

See @code{pdf_general_finite_discrete} for more details.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_general_finite_discrete}
@deffn {Function} random_general_finite_discrete (@var{v}) @
@fname{random_general_finite_discrete} (@var{v},@var{m})

Returns a general finite discrete random variate, with vector probabilities @math{v}. Calling @code{random_general_finite_discrete} with a second argument @var{m}, a random sample of size @var{m} will be simulated.

See @code{pdf_general_finite_discrete} for more details.

@c ===beg===
@c load ("distrib")$
@c random_general_finite_discrete([1,3,1,5]);
@c random_general_finite_discrete([1,3,1,5], 10);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) random_general_finite_discrete([1,3,1,5]);
(%o2)                          4
(%i3) random_general_finite_discrete([1,3,1,5], 10);
(%o3)           [4, 2, 2, 3, 2, 4, 4, 1, 2, 2]
@end example

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_binomial}
@deffn {Function} pdf_binomial (@var{x},@var{n},@var{p})
Returns the value at @var{x} of the probability function of a @math{Binomial(n,p)} random variable, with @math{0 \leq p \leq 1} and @math{n} a positive integer. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_binomial}
@deffn {Function} cdf_binomial (@var{x},@var{n},@var{p})
Returns the value at @var{x} of the distribution function of a @math{Binomial(n,p)} random variable, with @math{0 \leq p \leq 1} and @math{n} a positive integer.

@c ===beg===
@c load ("distrib")$
@c cdf_binomial(5,7,1/6);
@c float(%);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_binomial(5,7,1/6);
                            7775
(%o2)                       ----
                            7776
(%i3) float(%);
(%o3)               .9998713991769548
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_binomial}
@deffn {Function} quantile_binomial (@var{q},@var{n},@var{p})
Returns the @var{q}-quantile of a @math{Binomial(n,p)} random variable, with @math{0 \leq p \leq 1} and @math{n} a positive integer; in other words, this is the inverse of @code{cdf_binomial}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_binomial}
@deffn {Function} mean_binomial (@var{n},@var{p})
Returns the mean of a @math{Binomial(n,p)} random variable, with @math{0 \leq p \leq 1} and @math{n} a positive integer. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_binomial}
@deffn {Function} var_binomial (@var{n},@var{p})
Returns the variance of a @math{Binomial(n,p)} random variable, with @math{0 \leq p \leq 1} and @math{n} a positive integer. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_binomial}
@deffn {Function} std_binomial (@var{n},@var{p})
Returns the standard deviation of a @math{Binomial(n,p)} random variable, with @math{0 \leq p \leq 1} and @math{n} a positive integer. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_binomial}
@deffn {Function} skewness_binomial (@var{n},@var{p})
Returns the skewness coefficient of a @math{Binomial(n,p)} random variable, with @math{0 \leq p \leq 1} and @math{n} a positive integer. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_binomial}
@deffn {Function} kurtosis_binomial (@var{n},@var{p})
Returns the kurtosis coefficient of a @math{Binomial(n,p)} random variable, with @math{0 \leq p \leq 1} and @math{n} a positive integer. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_binomial}
@deffn {Function} random_binomial (@var{n},@var{p}) @
@fname{random_binomial} (@var{n},@var{p},@var{m})

Returns a @math{Binomial(n,p)} random variate, with @math{0 \leq p \leq 1} and @math{n} a positive integer. Calling @code{random_binomial} with a third argument @var{m}, a random sample of size @var{m} will be simulated.

The implemented algorithm is based on the one described in Kachitvichyanukul, V. and Schmeiser, B.W. (1988) @var{Binomial Random Variate Generation}. Communications of the ACM, 31, Feb., 216.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_poisson}
@deffn {Function} pdf_poisson (@var{x},@var{m})
Returns the value at @var{x} of the probability function of a @math{Poisson(m)} random variable, with @math{m>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_poisson}
@deffn {Function} cdf_poisson (@var{x},@var{m})
Returns the value at @var{x} of the distribution function of a @math{Poisson(m)} random variable, with @math{m>0}.

@c ===beg===
@c load ("distrib")$
@c cdf_poisson(3,5);
@c float(%);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_poisson(3,5);
(%o2)       gamma_incomplete_regularized(4, 5)
(%i3) float(%);
(%o3)               .2650259152973623
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_poisson}
@deffn {Function} quantile_poisson (@var{q},@var{m})
Returns the @var{q}-quantile of a @math{Poisson(m)} random variable, with @math{m>0}; in other words, this is the inverse of @code{cdf_poisson}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_poisson}
@deffn {Function} mean_poisson (@var{m})
Returns the mean of a @math{Poisson(m)} random variable, with  @math{m>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_poisson}
@deffn {Function} var_poisson (@var{m})
Returns the variance of a @math{Poisson(m)} random variable, with  @math{m>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_poisson}
@deffn {Function} std_poisson (@var{m})
Returns the standard deviation of a @math{Poisson(m)} random variable, with @math{m>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_poisson}
@deffn {Function} skewness_poisson (@var{m})
Returns the skewness coefficient of a @math{Poisson(m)} random variable, with @math{m>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_poisson}
@deffn {Function} kurtosis_poisson (@var{m})
Returns the kurtosis coefficient of a Poisson random variable  @math{Poi(m)}, with @math{m>0}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_poisson}
@deffn {Function} random_poisson (@var{m}) @
@fname{random_poisson} (@var{m},@var{n})

Returns a @math{Poisson(m)} random variate, with @math{m>0}. Calling @code{random_poisson} with a second argument @var{n}, a random sample of size @var{n} will be simulated.

The implemented algorithm is the one described in Ahrens, J.H. and Dieter, U. (1982) @var{Computer Generation of Poisson Deviates From Modified Normal Distributions}. ACM Trans. Math. Software, 8, 2, June,163-179.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_bernoulli}
@deffn {Function} pdf_bernoulli (@var{x},@var{p})
Returns the value at @var{x} of the probability function of a @math{Bernoulli(p)} random variable, with @math{0 \leq p \leq 1}.

The @math{Bernoulli(p)} random variable is equivalent to the @math{Binomial(1,p)}.

@c ===beg===
@c load ("distrib")$
@c pdf_bernoulli(1,p);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) pdf_bernoulli(1,p);
(%o2)                           p
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_bernoulli}
@deffn {Function} cdf_bernoulli (@var{x},@var{p})
Returns the value at @var{x} of the distribution function of a @math{Bernoulli(p)} random variable, with @math{0 \leq p \leq 1}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_bernoulli}
@deffn {Function} quantile_bernoulli (@var{q},@var{p})
Returns the @var{q}-quantile of a @math{Bernoulli(p)} random variable, with @math{0 \leq p \leq 1}; in other words, this is the inverse of @code{cdf_bernoulli}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_bernoulli}
@deffn {Function} mean_bernoulli (@var{p})
Returns the mean of a @math{Bernoulli(p)} random variable, with @math{0 \leq p \leq 1}.

The @math{Bernoulli(p)} random variable is equivalent to the @math{Binomial(1,p)}.

@c ===beg===
@c load ("distrib")$
@c mean_bernoulli(p);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) mean_bernoulli(p);
(%o2)                           p
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_bernoulli}
@deffn {Function} var_bernoulli (@var{p})
Returns the variance of a @math{Bernoulli(p)} random variable, with @math{0 \leq p \leq 1}.

The @math{Bernoulli(p)} random variable is equivalent to the @math{Binomial(1,p)}.

@c ===beg===
@c load ("distrib")$
@c var_bernoulli(p);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) var_bernoulli(p);
(%o2)                       (1 - p) p
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_bernoulli}
@deffn {Function} std_bernoulli (@var{p})
Returns the standard deviation of a @math{Bernoulli(p)} random variable, with @math{0 \leq p \leq 1}.

The @math{Bernoulli(p)} random variable is equivalent to the @math{Binomial(1,p)}.

@c ===beg===
@c load ("distrib")$
@c std_bernoulli(p);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) std_bernoulli(p);
(%o2)                           sqrt((1 - p) p)
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_bernoulli}
@deffn {Function} skewness_bernoulli (@var{p})
Returns the skewness coefficient of a @math{Bernoulli(p)} random variable, with @math{0 \leq p \leq 1}.

The @math{Bernoulli(p)} random variable is equivalent to the @math{Binomial(1,p)}.

@c ===beg===
@c load ("distrib")$
@c skewness_bernoulli(p);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) skewness_bernoulli(p);
                                    1 - 2 p
(%o2)                           ---------------
                                sqrt((1 - p) p)
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_bernoulli}
@deffn {Function} kurtosis_bernoulli (@var{p})
Returns the kurtosis coefficient of a @math{Bernoulli(p)} random variable, with @math{0 \leq p \leq 1}.

The @math{Bernoulli(p)} random variable is equivalent to the @math{Binomial(1,p)}.

@c ===beg===
@c load ("distrib")$
@c kurtosis_bernoulli(p);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) kurtosis_bernoulli(p);
                         1 - 6 (1 - p) p
(%o2)                    ---------------
                            (1 - p) p
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_bernoulli}
@deffn {Function} random_bernoulli (@var{p}) @
@fname{random_bernoulli} (@var{p},@var{n})

Returns a @math{Bernoulli(p)} random variate, with @math{0 \leq p \leq 1}. Calling @code{random_bernoulli} with a second argument @var{n}, a random sample of size @var{n} will be simulated.

This is a direct application of the @code{random} built-in Maxima function.

See also @mrefdot{random} To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn

@anchor{pdf_geometric}
@deffn {Function} pdf_geometric (@var{x},@var{p})
Returns the value at @var{x} of the probability function of a @math{Geometric(p)} random variable, with
@ifnottex
@math{0 < p <= 1}.
@end ifnottex
@tex
@math{0 < p \leq 1}.
@end tex

The probability function is defined as @math{p (1 - p)^x}.
This is interpreted as the probability of @math{x} failures before the first success.

@code{load("distrib")} loads this function.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_geometric}
@deffn {Function} cdf_geometric (@var{x},@var{p})
Returns the value at @var{x} of the distribution function of a @math{Geometric(p)} random variable, with
@ifnottex
@math{0 < p <= 1}.
@end ifnottex
@tex
@math{0 < p \leq 1}.
@end tex

The probability from which the distribution function is derived is defined as @math{p (1 - p)^x}.
This is interpreted as the probability of @math{x} failures before the first success.

@code{load("distrib")} loads this function.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_geometric}
@deffn {Function} quantile_geometric (@var{q},@var{p})
Returns the @var{q}-quantile of a @math{Geometric(p)} random variable, with
@ifnottex
@math{0 < p <= 1};
@end ifnottex
@tex
@math{0 < p \leq 1};
@end tex
in other words, this is the inverse of @code{cdf_geometric}.
Argument @var{q} must be an element of @math{[0,1]}.

The probability from which the quantile is derived is defined as @math{p (1 - p)^x}.
This is interpreted as the probability of @math{x} failures before the first success.

@code{load("distrib")} loads this function.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_geometric}
@deffn {Function} mean_geometric (@var{p})
Returns the mean of a @math{Geometric(p)} random variable, with
@ifnottex
@math{0 < p <= 1}.
@end ifnottex
@tex
@math{0 < p \leq 1}.
@end tex

The probability from which the mean is derived is defined as @math{p (1 - p)^x}.
This is interpreted as the probability of @math{x} failures before the first success.

@code{load("distrib")} loads this function.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_geometric}
@deffn {Function} var_geometric (@var{p})
Returns the variance of a @math{Geometric(p)} random variable, with
@ifnottex
@math{0 < p <= 1}.
@end ifnottex
@tex
@math{0 < p \leq 1}.
@end tex

The probability from which the variance is derived is defined as @math{p (1 - p)^x}.
This is interpreted as the probability of @math{x} failures before the first success.

@code{load("distrib")} loads this function.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_geometric}
@deffn {Function} std_geometric (@var{p})
Returns the standard deviation of a @math{Geometric(p)} random variable, with
@ifnottex
@math{0 < p <= 1}.
@end ifnottex
@tex
@math{0 < p \leq 1}.
@end tex

The probability from which the standard deviation is derived is defined as @math{p (1 - p)^x}.
This is interpreted as the probability of @math{x} failures before the first success.

@code{load("distrib")} loads this function.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_geometric}
@deffn {Function} skewness_geometric (@var{p})
Returns the skewness coefficient of a @math{Geometric(p)} random variable, with
@ifnottex
@math{0 < p <= 1}.
@end ifnottex
@tex
@math{0 < p \leq 1}.
@end tex

The probability from which the skewness is derived is defined as @math{p (1 - p)^x}.
This is interpreted as the probability of @math{x} failures before the first success.

@code{load("distrib")} loads this function.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_geometric}
@deffn {Function} kurtosis_geometric (@var{p})
Returns the kurtosis coefficient of a geometric random variable  @math{Geometric(p)}, with
@ifnottex
@math{0 < p <= 1}.
@end ifnottex
@tex
@math{0 < p \leq 1}.
@end tex

The probability from which the kurtosis is derived is defined as @math{p (1 - p)^x}.
This is interpreted as the probability of @math{x} failures before the first success.

@code{load("distrib")} loads this function.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_geometric}
@deffn {Function} random_geometric (@var{p}) @
@fname{random_geometric} (@var{p},@var{n})

@code{random_geometric(@var{p})} returns one random sample from a @math{Geometric(p)} distribution, with
@ifnottex
@math{0 < p <= 1}.
@end ifnottex
@tex
@math{0 < p \leq 1}.
@end tex

@code{random_geometric(@var{p}, @var{n})} returns a list of @var{n} random samples.

The algorithm is based on simulation of Bernoulli trials.

The probability from which the random sample is derived is defined as @math{p (1 - p)^x}.
This is interpreted as the probability of @math{x} failures before the first success.

@code{load("distrib")} loads this function.


@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_discrete_uniform}
@deffn {Function} pdf_discrete_uniform (@var{x},@var{n})
Returns the value at @var{x} of the probability function of a @math{Discrete Uniform(n)} random variable, with @math{n} a strictly positive integer. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_discrete_uniform}
@deffn {Function} cdf_discrete_uniform (@var{x},@var{n})
Returns the value at @var{x} of the distribution function of a @math{Discrete Uniform(n)} random variable, with @math{n} a strictly positive integer. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_discrete_uniform}
@deffn {Function} quantile_discrete_uniform (@var{q},@var{n})
Returns the @var{q}-quantile of a @math{Discrete Uniform(n)} random variable, with @math{n} a strictly positive integer; in other words, this is the inverse of @code{cdf_discrete_uniform}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_discrete_uniform}
@deffn {Function} mean_discrete_uniform (@var{n})
Returns the mean of a @math{Discrete Uniform(n)} random variable, with @math{n} a strictly positive integer. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_discrete_uniform}
@deffn {Function} var_discrete_uniform (@var{n})
Returns the variance of a @math{Discrete Uniform(n)} random variable, with @math{n} a strictly positive integer. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_discrete_uniform}
@deffn {Function} std_discrete_uniform (@var{n})
Returns the standard deviation of a @math{Discrete Uniform(n)} random variable, with @math{n} a strictly positive integer. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_discrete_uniform}
@deffn {Function} skewness_discrete_uniform (@var{n})
Returns the skewness coefficient of a @math{Discrete Uniform(n)} random variable, with @math{n} a strictly positive integer. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_discrete_uniform}
@deffn {Function} kurtosis_discrete_uniform (@var{n})
Returns the kurtosis coefficient of a @math{Discrete Uniform(n)} random variable, with @math{n} a strictly positive integer. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_discrete_uniform}
@deffn {Function} random_discrete_uniform (@var{n}) @
@fname{random_discrete_uniform} (@var{n},@var{m})

Returns a @math{Discrete Uniform(n)} random variate, with @math{n} a strictly positive integer. Calling @code{random_discrete_uniform} with a second argument @var{m}, a random sample of size @var{m} will be simulated.

This is a direct application of the @code{random} built-in Maxima function.

See also @mrefdot{random} To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_hypergeometric}
@deffn {Function} pdf_hypergeometric (@var{x},@var{n1},@var{n2},@var{n})
Returns the value at @var{x} of the probability function of a @math{Hypergeometric(n1,n2,n)}
random variable, with @var{n1}, @var{n2} and @var{n} non negative integers and @math{n<=n1+n2}.
Being @var{n1} the number of objects of class A, @var{n2} the number of objects of class B, and
@var{n} the size of the sample without replacement, this function returns the probability of
event "exactly @var{x} objects are of class A". 

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_hypergeometric}
@deffn {Function} cdf_hypergeometric (@var{x},@var{n1},@var{n2},@var{n})
Returns the value at @var{x} of the distribution function of a @math{Hypergeometric(n1,n2,n)} 
random variable, with @var{n1}, @var{n2} and @var{n} non negative integers and @math{n<=n1+n2}. 
See @code{pdf_hypergeometric} for a more complete description.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_hypergeometric}
@deffn {Function} quantile_hypergeometric (@var{q},@var{n1},@var{n2},@var{n})
Returns the @var{q}-quantile of a @math{Hypergeometric(n1,n2,n)} random variable, with @var{n1}, @var{n2} and @var{n} non negative integers and @math{n<=n1+n2}; in other words, this is the inverse of @code{cdf_hypergeometric}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_hypergeometric}
@deffn {Function} mean_hypergeometric (@var{n1},@var{n2},@var{n})
Returns the mean of a discrete uniform random variable @math{Hyp(n1,n2,n)}, with @var{n1}, @var{n2} and @var{n} non negative integers and @math{n<=n1+n2}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_hypergeometric}
@deffn {Function} var_hypergeometric (@var{n1},@var{n2},@var{n})
Returns the variance of a hypergeometric  random variable @math{Hyp(n1,n2,n)}, with @var{n1}, @var{n2} and @var{n} non negative integers and @math{n<=n1+n2}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_hypergeometric}
@deffn {Function} std_hypergeometric (@var{n1},@var{n2},@var{n})
Returns the standard deviation of a @math{Hypergeometric(n1,n2,n)} random variable, with @var{n1}, @var{n2} and @var{n} non negative integers and @math{n<=n1+n2}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_hypergeometric}
@deffn {Function} skewness_hypergeometric (@var{n1},@var{n2},@var{n})
Returns the skewness coefficient of a @math{Hypergeometric(n1,n2,n)} random variable, with @var{n1}, @var{n2} and @var{n} non negative integers and @math{n<=n1+n2}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_hypergeometric}
@deffn {Function} kurtosis_hypergeometric (@var{n1},@var{n2},@var{n})
Returns the kurtosis coefficient of a @math{Hypergeometric(n1,n2,n)} random variable, with @var{n1}, @var{n2} and @var{n} non negative integers and @math{n<=n1+n2}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_hypergeometric}
@deffn {Function} random_hypergeometric (@var{n1},@var{n2},@var{n}) @
@fname{random_hypergeometric} (@var{n1},@var{n2},@var{n},@var{m})

Returns a @math{Hypergeometric(n1,n2,n)} random variate, with @var{n1}, @var{n2} and @var{n} non negative integers and @math{n<=n1+n2}. Calling @code{random_hypergeometric} with a fourth argument @var{m}, a random sample of size @var{m} will be simulated.

Algorithm described in Kachitvichyanukul, V., Schmeiser, B.W. (1985) @var{Computer generation of hypergeometric random variates.} Journal of Statistical Computation and Simulation 22, 127-145.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn


@anchor{pdf_negative_binomial}
@deffn {Function} pdf_negative_binomial (@var{x},@var{n},@var{p})
Returns the value at @var{x} of the probability function of a @math{Negative Binomial(n,p)} random variable, with @math{0 < p \leq 1} and @math{n} a positive number. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{cdf_negative_binomial}
@deffn {Function} cdf_negative_binomial (@var{x},@var{n},@var{p})
Returns the value at @var{x} of the distribution function of a @math{Negative Binomial(n,p)} random variable, with @math{0 < p \leq 1} and @math{n} a positive number.

@c ===beg===
@c load ("distrib")$
@c cdf_negative_binomial(3,4,1/8);
@c ===end===
@example
(%i1) load ("distrib")$
(%i2) cdf_negative_binomial(3,4,1/8);
                            3271
(%o2)                      ------
                           524288
@end example

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{quantile_negative_binomial}
@deffn {Function} quantile_negative_binomial (@var{q},@var{n},@var{p})
Returns the @var{q}-quantile of a @math{Negative Binomial(n,p)} random variable, with @math{0 < p \leq 1} and @math{n} a positive number; in other words, this is the inverse of @code{cdf_negative_binomial}. Argument @var{q} must be an element of @math{[0,1]}. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{mean_negative_binomial}
@deffn {Function} mean_negative_binomial (@var{n},@var{p})
Returns the mean of a @math{Negative Binomial(n,p)} random variable, with @math{0 < p \leq 1} and @math{n} a positive number. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{var_negative_binomial}
@deffn {Function} var_negative_binomial (@var{n},@var{p})
Returns the variance of a @math{Negative Binomial(n,p)} random variable, with @math{0 < p \leq 1} and @math{n} a positive number. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{std_negative_binomial}
@deffn {Function} std_negative_binomial (@var{n},@var{p})
Returns the standard deviation of a @math{Negative Binomial(n,p)} random variable, with @math{0 < p \leq 1} and @math{n} a positive number. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{skewness_negative_binomial}
@deffn {Function} skewness_negative_binomial (@var{n},@var{p})
Returns the skewness coefficient of a @math{Negative Binomial(n,p)} random variable, with @math{0 < p \leq 1} and @math{n} a positive number. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{kurtosis_negative_binomial}
@deffn {Function} kurtosis_negative_binomial (@var{n},@var{p})
Returns the kurtosis coefficient of a @math{Negative Binomial(n,p)} random variable, with @math{0 < p \leq 1} and @math{n} a positive number. To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@closecatbox

@end deffn


@anchor{random_negative_binomial}
@deffn {Function} random_negative_binomial (@var{n},@var{p}) @
@fname{random_negative_binomial} (@var{n},@var{p},@var{m})

Returns a @math{Negative Binomial(n,p)} random variate, with @math{0 < p \leq 1} and @math{n} a positive number. Calling @code{random_negative_binomial} with a third argument @var{m}, a random sample of size @var{m} will be simulated.

Algorithm described in Devroye, L. (1986) @var{Non-Uniform Random Variate Generation}. Springer Verlag, p. 480.

To make use of this function, write first @code{load("distrib")}.

@opencatbox
@category{Package distrib}
@category{Random numbers}
@closecatbox

@end deffn