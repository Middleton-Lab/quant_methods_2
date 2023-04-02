## Key Concepts

- Sample
- Population
- Distributions
- Null & Alternative
- Central limit theorm


https://openintro-ims.netlify.app/foundations-mathematical.html#foundations-mathematical

## Outline
### week 1
Idea behind monte carlo
Intro / Background / Prerequisites
Resources
Goals, concepts

Motivations

What questions do we ask when we use statistics?
Null models

Main applications & Example uses

Cautionary tales
ACF/CCF hummingbirds


Problem set:
Give a data set that was generated from a null & ask them to visualize and summarize.
Some simple programming - pulling samples, assigning and tracking ids, loops and mapping

## Week 2
Sampling from data 1- better names

Bootstrap

## The General Procedure

1. Decide on a test statistic
1. Calculate the test statistic for the *observed* data
1. Randomly shuffle the observations
1. Calculate the test statistic for that group
1. Repeat many times to generate an empirical null distribution
1. Determine the proportion of random combinations resulting in a test statistic more extreme than the observed value ("empirical *P*")

Randomization
General workflow
Simple designs & examples
Show models slide
Randomization use cases


Other methods
Jackknife
Bootstrap
Problem set: skills needed - loops, mapping, functions, seeds, tracking ids. Pulling out test statistics, Perform test on a dataset violating assumptions - standard, nonparametric, randomization
CI jackknife same as CI on mean
hypoth test with jackknife

## Week 3	
Sampling from data 2
Conservative vs. anti-conservative tests
As a method to answer - is this ok?
Ratios - as an example

Complex designs
Nesting, time series, levels, multivariate
Multiple testing and how many permutations, empirical fdr
Different ways to parallelize
Base R
furrr
Scripts that accept parameters, calling R scripts from bash scripts
Generality - cross validation
Problem set - parallel stuff, seeds, lewis


Simulations 1

simulations to verify methods they have learned


eddible package: https://emitanaka.org/edibble-book/index.html
Distributions simulation: https://mgoodman.shinyapps.io/distributions-lab/
Simstudy:https://cran.r-project.org/web/packages/simstudy/ 
Faux https://debruine.github.io/faux/ 
Problem set

Simulations 2
When the null needs to be simulated
Simulating data
Power
Problem set: assigned at start - use your own data to use one method from class - consult ahead of time with instructors

Problem set: assigned at start - use your own data to use one method from class - consult ahead of time with instructors