# To Clear working environment
rm(list=ls())
graphics.off()

# Load libraries
library(tidyverse)
library(cowplot)
library(nycflights13)

flights <- flights
planes <- planes

flights$month <- as.factor(flights$month)
flights$carrier <- as.factor(flights$carrier)
flights$origin <- as.factor(flights$origin)
flights$dest <- as.factor(flights$dest)

flights %>% 

flights %>% 
  filter(dest %in% c("LAX","SFO")) %>% 
  group_by(month,carrier,origin,dest) %>% 
  summarise(n = length(month)) %>% 
  ggplot(aes(x = month, y = n, color = carrier,group = carrier, shape = dest))+
  geom_point()+
  geom_line()+
  facet_grid(origin~dest)

