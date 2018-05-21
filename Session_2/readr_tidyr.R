# Load libraries
library(tidyverse)
library(gapminder)

# Importing data ----------------------------------------------------------

read_csv("Antibiotics.csv")
data <- read_csv("Antibiotics.csv")

data

# Tidyr -------------------------------------------------------------------

# 'Wide' data
table4a

# gather- makes 'wide' data 'long'

table4a %>% 
  gather(year, cases, 2:3)


# 'Long' data
table2

# Spread -makes 'long' data 'wide'
table2 %>% 
  spread(type,count)


# Make data from wide to long ---------------------------------------------

long <- data %>%
  gather(organism, count, 2:10)
  
long

# Split single column to multiple columns ---------------------------------

split <- long %>%
  separate(organism, into=c("Experiment", "Bacteria"),
           sep = "_")

split
  

# Export data -------------------------------------------------------------

write_csv(split, "Tidy_demo_antibiotics.csv")
