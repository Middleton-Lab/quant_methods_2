# Problem Sets

## Week 1


## Week 2


## Week 3


## Week 4


## Week 5


# Books

- McElreath R. 2020. *Statistical Rethinking: A Bayesian Course with Examples in R and Stan*. 2nd ed. 
- Johnson AA, Ott MQ, Dogucu M. 2022. *Bayes Rules! An Introduction to Applied Bayesian Modeling*. Chapman & Hall.
  - https://www.bayesrulesbook.com/

- Gelman A, Hill J, Vehtari A. 2020. *Regression and Other Stories*. Cambridge University Press.
  - https://avehtari.github.io/ROS-Examples/
- Gelman A, Carlin JB, Stern HS, Dunson DB, Vehtari A, Rubin DB. 2013. *Bayesian Data Analysis*. 3rd ed. Boca Raton, FL: CRC Press.
- Kruschke JK. 2015. *Doing Bayesian Data Analysis: a Tutorial with R, JAGS, and Stan*. 2nd ed. Boston, MA: Academic Press.

# Other resources


# Notes

https://github.com/wzchen/probability_cheatsheet

Sampling is not optimization

"...if prior information is available, you can use it, and, if not, Bayesian regression with weakly informative default priors still has the advantage of yielding stable estimates and producing simulations that enable you to express inferential and predictive uncertainty (that is, estimates with uncertainties and probabilistic predictions or forecasts)." Gelman et al. (2020), p. 16

Gelman et al p. 81
Basic regression model: y = a * bx + Error

Expansions:

1. More predictors y = b0 + b1 x1 + b2 x2 + ... + bk xk
2. Nonadditive models with interactions
3. GLMs
4. Nonlinear models: log y = a * b log x + error
5. Nonparametric models (splines, GAMs, et al.)
6. Multilevel models
7. Measurement error models

"The safest interpretation of a regression is as a comparison." Not effects. p. 85

# Prior exploration

```r
# https://gist.githubusercontent.com/andrewheiss/a4e0c0ab2d735625ac17ec8a081f0f32/raw/aa8734075c24b926f3d3fb8d1922c8e846d0a034/plot-priors-automatically.md

library(tidyverse)
library(tidybayes)
library(brms)
library(ggtext)

priors <- c(prior(normal(20, 5), class = Intercept),
            prior(normal(0, 2), class = b),
            prior(exponential(1), class = sigma),
            prior(exponential(1), class = sd),
            prior(lkj(2), class = cor),
            prior(beta(1, 1), class = hu))

priors %>% 
  parse_dist() %>% 
  # K = dimension of correlation matrix; 
  # ours is 2x2 here because we have one random slope
  marginalize_lkjcorr(K = 2) %>%
  mutate(nice_title = glue::glue("**{class}**<br>{prior}")) %>% 
  ggplot(aes(y = 0, dist = .dist, args = .args, fill = prior)) +
  stat_slab(normalize = "panels") +
  scale_fill_viridis_d(option = "plasma", end = 0.9) +
  facet_wrap(vars(nice_title), scales = "free_x") +
  guides(fill = "none") +
  labs(x = NULL, y = NULL) +
  theme_bw() +
  theme(strip.text = element_markdown(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank())
```


