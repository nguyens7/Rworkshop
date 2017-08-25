# To Clear working environment
rm(list=ls())
graphics.off()

# Libraries ---------------------------------------------------------------

library(tidyverse)
library(broom)
library(pwr)

# Power analysis ----------------------------------------------------------

# t test
pwr.t.test(n = 20, d = 0.4 , sig.level = 0.05 , power = , type = c("paired"))

# ANOVA
pwr.anova.test(k = 8  ,n = ,f = 0.4 , sig.level = 0.05, power = 0.8)


# Load mtcars dataset -----------------------------------------------------
cars <- mtcars

# Make cylinders categorical factors
cars$cyl <- as.factor(cars$cyl)

# Filter on 6 and 4 cylinder engines
cars1 <- cars %>% 
  filter(cyl == 6 | cyl == 4)

# Perform t.test
ttest <- t.test(mpg~cyl,data = cars1)

# tidy it
tidy_data <- tidy(ttest)
tidy_data



# Compare mpg between manual and automatic transmission (am)
t.test(mpg~am, data = cars)



# ANOVA -------------------------------------------------------------------
ANOVA <- aov(mpg~cyl, data = cars)

tidy(ANOVA)

TukeyHSD(ANOVA)

tidy(TukeyHSD(ANOVA))

