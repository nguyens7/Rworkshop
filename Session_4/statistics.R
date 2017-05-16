# To Clear working environment
rm(list=ls())
graphics.off()

# Libraries ---------------------------------------------------------------

library(tidyverse)
library(cowplot)
library(broom)

cars <- mtcars

cars1 <- cars %>% 
  filter(cyl == 6 | cyl == 4)

ttest <- t.test(mpg~cyl,data = cars1)

tidy_data <- tidy(ttest)

ANOVA <- aov(mpg~cyl, data = cars)

tidy(ANOVA)

TukeyHSD(ANOVA)

cars$cyl <- as.factor(cars$cyl)
