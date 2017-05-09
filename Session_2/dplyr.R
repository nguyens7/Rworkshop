# To Clear working environment
rm(list=ls())
graphics.off()

# Load libraries
library(cowplot)
library(tidyverse)
library(nycflights13)

# Load in data from nycflights13
flights <- flights
planes <- planes
weather <- weather
airlines <- airlines

# Filter ------------------------------------------------------------------

UA <- flights %>%
  filter(carrier == "UA")


# Select ------------------------------------------------------------------

flights_small <- flights %>%
  select(year:carrier)

# Rename ------------------------------------------------------------------

flights1 <- flights %>% 
  rename(date_time_hour = time_hour)
 

# Arrange -----------------------------------------------------------------

flights %>%
  

# Mutate ------------------------------------------------------------------

flights %>%



# Group by and Summarise --------------------------------------------------

flights %>%
  

# Advanced dplyr ----------------------------------------------------------

delays <- flights %>%
  group_by(dest) %>% 
  summarise( count = n(),
             dist = mean(distance, na.rm = TRUE),
             delay = mean (arr_delay, na.rm = TRUE)) %>% 
  filter(count > 20 & dest != "HNL")

delays %>% 
  ggplot(aes(x= dist, y= delay))+
  geom_point(aes(size = count, alpha = 1/3))+
  geom_smooth(se = FALSE)


flights$month <- as.factor(flights$month)
flights$carrier <- as.factor(flights$carrier)
flights$origin <- as.factor(flights$origin)
flights$dest <- as.factor(flights$dest)

flights %>% 
  filter(dest %in% c("LAX", "SFO")) %>% 
  group_by(month,dest,carrier,origin) %>% 
  summarise(n = length(month)) %>% 
  ggplot(aes(x = month, y = n, color = carrier, group = carrier, shape = dest))+
  geom_point(size = 4)+
  geom_line(size = 2)+
  facet_grid(origin~dest)

