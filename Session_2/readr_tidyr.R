library(tidyverse)
library(gapminder)

# Set working directory ---------------------------------------------------
setwd("~/Desktop")
getwd()

read_csv()

table4a %>% 
  gather(year,cases,2-3)

table2 %>% 
  spread(type,count)


