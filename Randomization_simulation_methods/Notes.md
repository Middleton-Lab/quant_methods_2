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



Jackknife 

```{r}
#Thermal Tolerance 
jk.h2<-function(pheno,geno)
{
  #make sure geno is factor
  geno<-as.factor(geno)
  
  #get genotype IDs
  geno.ids<-unique(geno)
  
  #how many genotypes?
  ngeno<-length(geno.ids)
  
  #set up output vector
  H2.p<-numeric(length=ngeno)
  
  #get estimate
  afit<-aov(pheno~geno)
  suma<-unlist(summary(afit))
  #get variance within groups
  sw<-suma['Mean Sq2']
  
  #get variance between groups SEE Lessels and Boag (1987)
  Ng<-length(unique(geno))
  ns<-table(geno)
  n0<-(1/(Ng-1)) * (sum(ns)-(sum(ns^2)/sum(ns)))
  
  sa<-(suma['Mean Sq1']-suma['Mean Sq2'])/n0
  
  #Observed Heritability
  H2.0<-sa/(sa+sw)
  
  
  #do drop one jackknife
  for (i in 1:ngeno)
  {
    pheno.s<-pheno[geno!=geno.ids[i]]
    geno.s<-geno[geno!=geno.ids[i]]
    #Get new estimate
    afit<-aov(pheno.s~geno.s)
    suma<-unlist(summary(afit))
    #get variance within groups
    sw<-suma['Mean Sq2']
    
    #get variance between groups SEE Lessels and Boag (1987)
    Ng<-length(unique(geno.s))
    ns<-table(geno.s)
    n0<-(1/(Ng-1)) * (sum(ns)-(sum(ns^2)/sum(ns)))
    
    sa<-(suma['Mean Sq1']-suma['Mean Sq2'])/n0
    
    #New Heritability
    H2<-sa/(sa+sw)
    
    #Pseudovalue
    H2.p[i]<-(nril*H2.0) - ((nril-1)*H2)
    #cat(i, '\n')
  }
  output<-list(c(mean(H2.p),sd(H2.p)))
  return(output)
}


ThermTol.h2 <- h2.lme(geno=as.factor(TT$patRIL), pheno=TT$ThermTolNorm)

geno <- as.factor(TT$patRIL)
pheno <- TT$ThermTolNorm

afit<-lme(pheno ~ 1 , random= ~1 | geno, method="ML")
afit.n <- lm(pheno ~ 1)
anova.lme(afit.n, afit)

#check
x2val <- -2*logLik(afit.n, REML=FALSE) + 2* logLik(afit, REML=FALSE)
pchisq(x2val, df=1, lower.tail=F, log.p = TRUE)

ThermTol.jk <- jk.h2.lme(geno=as.factor(TT$patRIL), pheno=TT$ThermTolNorm)
mean(ThermTol.jk, na.rm=TRUE)
sd(ThermTol.jk, na.rm=TRUE)
nn <- length(ThermTol.jk[is.na(ThermTol.jk)==FALSE])
tval <- qt(0.025, nn-1, lower.tail=FALSE)
mean(ThermTol.jk, na.rm=TRUE) + tval*sd(ThermTol.jk, na.rm=TRUE)/sqrt(nn)
mean(ThermTol.jk, na.rm=TRUE) - tval*sd(ThermTol.jk, na.rm=TRUE)/sqrt(nn)


```


Bootstrap

Randomization
General workflow
Simple designs & examples
Show models slide
Randomization use cases


As a method to answer - is this ok?
Conservative vs. anti-conservative tests
Ratios - as an example
Other methods
Jackknife
Bootstrap
Problem set: skills needed - loops, mapping, functions, seeds, tracking ids. Pulling out test statistics, Perform test on a dataset violating assumptions - standard, nonparametric, randomization


## Week 3	
Sampling from data 2
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