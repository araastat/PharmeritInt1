---
title       : Intermediate R Part I
subtitle    : Pharmerit, LLC
author      : Abhijit Dasgupta
job         : ARAASTAT
github:
  user: araastat
  repo : PharmeritInt1
  branch: "master"
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme : solarized-light
widgets     : mathjax       # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
logo : Rlogo-1.png
license : by-nc-nd
--- .segue .dark

## Generalized linear models




---

## A quick review of GLMs

Generalized linear models are extensions of linear models, that are based on the exponential
family of distributions. They are characterized by three components:

+ A distribution (normal/Gaussian, exponential, binomial, Poisson, Weibull, and so on)
+ A linear predictor $\eta = X\beta$
+ A _link function_ relating the expected outcome to the predictor: $E(Y) = \mu = g^{-1}(\eta)$. There are standard or "natural" links for different distributions, giving rise to familiar models

This framework includes several classical models:

1. Ordinary least squares / linear regression
2. Logistic regression (Note, probit and tobit regressions involve changing the link, but in the same framework)
3. Poisson regression / log-linear models
4. Weibull regression

---

## Linear regression

We want to model a structure
$$
y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + \beta_3 x_3 + \varepsilon
$$
from data, estimate the coefficients $\beta$, obtain their standard errors, and
perform statistical inference (hypothesis testing, confidence intervals)

---

## Linear regression


```r
> data(mtcars)
> model1 <- lm(mpg ~ disp + hp + drat + wt + as.factor(cyl) + as.factor(gear), 
+     data = mtcars)
```


```

Call:
lm(formula = mpg ~ disp + hp + drat + wt + as.factor(cyl) + as.factor(gear), 
    data = mtcars)

Coefficients:
     (Intercept)              disp                hp              drat  
         34.5882            0.0082           -0.0349           -0.0177  
              wt   as.factor(cyl)6   as.factor(cyl)8  as.factor(gear)4  
         -3.2786           -3.1038           -2.2208            1.7460  
as.factor(gear)5  
          2.1689  
```


---

## Linear regression

Arguments:

```r
> args(lm)
```

```
function (formula, data, subset, weights, na.action, method = "qr", 
    model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, 
    contrasts = NULL, offset, ...) 
NULL
```


Results

```r
> names(model1)
```

```
 [1] "coefficients"  "residuals"     "effects"       "rank"         
 [5] "fitted.values" "assign"        "qr"            "df.residual"  
 [9] "contrasts"     "xlevels"       "call"          "terms"        
[13] "model"        
```


---

## Linear regression


```r
> summ1 <- summary(model1)
```


```

Call:
lm(formula = mpg ~ disp + hp + drat + wt + as.factor(cyl) + as.factor(gear), 
    data = mtcars)

Residuals:
   Min     1Q Median     3Q    Max 
-3.499 -1.226 -0.423  1.292  5.343 

Coefficients:
                 Estimate Std. Error t value Pr(>|t|)    
(Intercept)       34.5882     7.3448    4.71  9.6e-05 ***
disp               0.0082     0.0145    0.57    0.576    
hp                -0.0349     0.0187   -1.87    0.074 .  
drat              -0.0177     1.8457   -0.01    0.992    
wt                -3.2786     1.3090   -2.50    0.020 *  
as.factor(cyl)6   -3.1038     1.6530   -1.88    0.073 .  
as.factor(cyl)8   -2.2208     3.3402   -0.66    0.513    
as.factor(gear)4   1.7460     2.1701    0.80    0.429    
as.factor(gear)5   2.1689     2.3779    0.91    0.371    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 2.56 on 23 degrees of freedom
Multiple R-squared:  0.866,	Adjusted R-squared:  0.819 
F-statistic: 18.5 on 8 and 23 DF,  p-value: 2.58e-08
```


---

## Linear regression


```r
> summ1$coef
```

```
                  Estimate Std. Error   t value  Pr(>|t|)
(Intercept)      34.588188    7.34481  4.709199 9.609e-05
disp              0.008195    0.01446  0.566602 5.765e-01
hp               -0.034901    0.01866 -1.870421 7.421e-02
drat             -0.017740    1.84570 -0.009611 9.924e-01
wt               -3.278616    1.30900 -2.504663 1.979e-02
as.factor(cyl)6  -3.103760    1.65305 -1.877597 7.318e-02
as.factor(cyl)8  -2.220765    3.34017 -0.664866 5.127e-01
as.factor(gear)4  1.746017    2.17011  0.804576 4.293e-01
as.factor(gear)5  2.168943    2.37790  0.912124 3.712e-01
```


```r
> class(summ1$coef)
```

```
[1] "matrix"
```


---

## Linear regression

```r
> par(mfrow = c(2, 2))  # Arrange in 2x2 grid
> plot(model1)
```

<img src="figure/unnamed-chunk-9.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" height="450px" />


---
## Linear regression



```r
> require(xtable)
> print(xtable(model1), type = "html")
```

<!-- html table generated in R 3.0.1 by xtable 1.7-1 package -->
<!-- Fri Aug 23 07:20:59 2013 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> Estimate </TH> <TH> Std. Error </TH> <TH> t value </TH> <TH> Pr(&gt |t|) </TH>  </TR>
  <TR> <TD align="right"> (Intercept) </TD> <TD align="right"> 34.5882 </TD> <TD align="right"> 7.3448 </TD> <TD align="right"> 4.71 </TD> <TD align="right"> 0.0001 </TD> </TR>
  <TR> <TD align="right"> disp </TD> <TD align="right"> 0.0082 </TD> <TD align="right"> 0.0145 </TD> <TD align="right"> 0.57 </TD> <TD align="right"> 0.5765 </TD> </TR>
  <TR> <TD align="right"> hp </TD> <TD align="right"> -0.0349 </TD> <TD align="right"> 0.0187 </TD> <TD align="right"> -1.87 </TD> <TD align="right"> 0.0742 </TD> </TR>
  <TR> <TD align="right"> drat </TD> <TD align="right"> -0.0177 </TD> <TD align="right"> 1.8457 </TD> <TD align="right"> -0.01 </TD> <TD align="right"> 0.9924 </TD> </TR>
  <TR> <TD align="right"> wt </TD> <TD align="right"> -3.2786 </TD> <TD align="right"> 1.3090 </TD> <TD align="right"> -2.50 </TD> <TD align="right"> 0.0198 </TD> </TR>
  <TR> <TD align="right"> as.factor(cyl)6 </TD> <TD align="right"> -3.1038 </TD> <TD align="right"> 1.6530 </TD> <TD align="right"> -1.88 </TD> <TD align="right"> 0.0732 </TD> </TR>
  <TR> <TD align="right"> as.factor(cyl)8 </TD> <TD align="right"> -2.2208 </TD> <TD align="right"> 3.3402 </TD> <TD align="right"> -0.66 </TD> <TD align="right"> 0.5127 </TD> </TR>
  <TR> <TD align="right"> as.factor(gear)4 </TD> <TD align="right"> 1.7460 </TD> <TD align="right"> 2.1701 </TD> <TD align="right"> 0.80 </TD> <TD align="right"> 0.4293 </TD> </TR>
  <TR> <TD align="right"> as.factor(gear)5 </TD> <TD align="right"> 2.1689 </TD> <TD align="right"> 2.3779 </TD> <TD align="right"> 0.91 </TD> <TD align="right"> 0.3712 </TD> </TR>
   </TABLE>


---

## Generalized linear models

The way you do GLM's in R is basically the same as doing linear regression.

You just have to specify a distribution and link.

What you specify is a `family`, i.e., a family of distributions, with a link specification.

---

## Logistic regression

Logistic regression can be run if the outcome _Y_ is either a __binary__ or a 
__binomial__ variable.


```r
> data(infert)
> model2 <- glm(case ~ spontaneous + induced, data = infert, family = binomial())
> model2
```

```

Call:  glm(formula = case ~ spontaneous + induced, family = binomial(), 
    data = infert)

Coefficients:
(Intercept)  spontaneous      induced  
     -1.708        1.197        0.418  

Degrees of Freedom: 247 Total (i.e. Null);  245 Residual
Null Deviance:	    316 
Residual Deviance: 280 	AIC: 286
```


---

## Logistic regression


```r
> summary(model2)$coef
```

```
            Estimate Std. Error z value  Pr(>|z|)
(Intercept)  -1.7079     0.2677  -6.380 1.776e-10
spontaneous   1.1972     0.2116   5.657 1.543e-08
induced       0.4181     0.2056   2.033 4.201e-02
```

Coefficients are interpreted as log-odds ratios.

---

## Logistic regression

If you data is binomial rather than binary, specify number of successes and failures as the outcome


```r
> for (i in 1:3) esoph[, i] <- as.factor(as.character(esoph[, i]))
> model3 <- glm(cbind(ncases, ncontrols) ~ agegp + tobgp * alcgp, data = esoph, 
+     family = binomial())
> model3
```

```

Call:  glm(formula = cbind(ncases, ncontrols) ~ agegp + tobgp * alcgp, 
    family = binomial(), data = esoph)

Coefficients:
           (Intercept)              agegp35-44              agegp45-54  
                -6.391                   1.586                   2.983  
            agegp55-64              agegp65-74                agegp75+  
                 3.350                   3.729                   3.655  
            tobgp10-19              tobgp20-29                tobgp30+  
                 1.147                   1.210                   1.785  
             alcgp120+              alcgp40-79             alcgp80-119  
                 2.818                   1.678                   2.033  
  tobgp10-19:alcgp120+    tobgp20-29:alcgp120+      tobgp30+:alcgp120+  
                -1.046                  -0.892                  -1.567  
 tobgp10-19:alcgp40-79   tobgp20-29:alcgp40-79     tobgp30+:alcgp40-79  
                -0.988                  -0.979                  -0.880  
tobgp10-19:alcgp80-119  tobgp20-29:alcgp80-119    tobgp30+:alcgp80-119  
                -0.972                  -1.082                  -0.988  

Degrees of Freedom: 87 Total (i.e. Null);  67 Residual
Null Deviance:	    227 
Residual Deviance: 47.5 	AIC: 237
```


*** pnotes


`tobgp * alcgp` is the same as `tobgp + alcgp + tobgp:alcgp`, i.e., main effects 
 and multiplicative interaction

---
## Poisson regression


```r
> counts <- c(18, 17, 15, 20, 10, 20, 25, 13, 12)
> outcome <- gl(3, 1, 9)
> treatment <- gl(3, 3)
> d.AD <- data.frame(treatment, outcome, counts)
> model4 <- glm(counts ~ outcome + treatment, family = poisson())
> model4
```

```

Call:  glm(formula = counts ~ outcome + treatment, family = poisson())

Coefficients:
(Intercept)     outcome2     outcome3   treatment2   treatment3  
   3.04e+00    -4.54e-01    -2.93e-01     1.34e-15     1.42e-15  

Degrees of Freedom: 8 Total (i.e. Null);  4 Residual
Null Deviance:	    10.6 
Residual Deviance: 5.13 	AIC: 56.8
```


---
## Poisson regression

```r
> summary(model4)$coef
```

```
              Estimate Std. Error    z value  Pr(>|z|)
(Intercept)  3.045e+00     0.1709  1.781e+01 5.427e-71
outcome2    -4.543e-01     0.2022 -2.247e+00 2.465e-02
outcome3    -2.930e-01     0.1927 -1.520e+00 1.285e-01
treatment2   1.338e-15     0.2000  6.690e-15 1.000e+00
treatment3   1.421e-15     0.2000  7.105e-15 1.000e+00
```

Coefficients are interpreted as log-ratios.

---
## Poisson regression

```r
> print(xtable(model4), type = "html")
```

<!-- html table generated in R 3.0.1 by xtable 1.7-1 package -->
<!-- Fri Aug 23 07:21:00 2013 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> Estimate </TH> <TH> Std. Error </TH> <TH> z value </TH> <TH> Pr(&gt |z|) </TH>  </TR>
  <TR> <TD align="right"> (Intercept) </TD> <TD align="right"> 3.0445 </TD> <TD align="right"> 0.1709 </TD> <TD align="right"> 17.81 </TD> <TD align="right"> 0.0000 </TD> </TR>
  <TR> <TD align="right"> outcome2 </TD> <TD align="right"> -0.4543 </TD> <TD align="right"> 0.2022 </TD> <TD align="right"> -2.25 </TD> <TD align="right"> 0.0246 </TD> </TR>
  <TR> <TD align="right"> outcome3 </TD> <TD align="right"> -0.2930 </TD> <TD align="right"> 0.1927 </TD> <TD align="right"> -1.52 </TD> <TD align="right"> 0.1285 </TD> </TR>
  <TR> <TD align="right"> treatment2 </TD> <TD align="right"> 0.0000 </TD> <TD align="right"> 0.2000 </TD> <TD align="right"> 0.00 </TD> <TD align="right"> 1.0000 </TD> </TR>
  <TR> <TD align="right"> treatment3 </TD> <TD align="right"> 0.0000 </TD> <TD align="right"> 0.2000 </TD> <TD align="right"> 0.00 </TD> <TD align="right"> 1.0000 </TD> </TR>
   </TABLE>


--- .segue .dark

## Predictive modeling

--- .segue .dark

## Thank you



