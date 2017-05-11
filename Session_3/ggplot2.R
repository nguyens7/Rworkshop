# To Clear working environment
rm(list=ls())
graphics.off()

# Load libraries
library(plotly)
library(cowplot)
library(tidyverse)
library(gapminder)
library(nycflights13)
library(gganimate)

# Load gapminder data
data <- gapminder

p1 <- data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, color = continent, frame = year))+
  geom_point(aes(text = paste ("country:",country)))+
  scale_x_log10()

p1 + facet_wrap(~year)

ggplotly(p1)
 
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp))+
  geom_point()

data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp))+
  geom_point()+
  scale_x_log10()

data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop))+
  geom_point()+
  scale_x_log10()


data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, color = continent))+
  geom_point()+
  scale_x_log10()


# nycflights data ---------------------------------------------------------

flights <- flights

# Determine # of flights each month from LGA
flights_by_month <- flights %>%
  filter(origin == 'LGA') %>% 
  group_by(month) %>% 
  summarise(count = n())

# Base plot (defines axes)
flights_by_month %>% 
  ggplot(aes(x = month, y = count))

# Add bar columns
flights_by_month %>% 
  ggplot(aes(x = month, y = count)) +
  geom_col() # you could also use 'geom_bar(stat = "identity")' instead

# Add points instead
flights_by_month %>% 
  ggplot(aes(x = month, y = count)) +
  geom_point()

# Connect points
flights_by_month %>% 
  ggplot(aes(x = month, y = count)) +
  geom_point()+
  geom_line()


# make 'month' a "categorical" factor column
flights_by_month$month <-  as.factor(flights_by_month$month)

# Since we have only one observation, make group = 1 to connect the points
flights_by_month %>% 
  ggplot(aes(x = month, y = count, group = 1)) +
  geom_point()+
  geom_line()

# Make this into a plot object
flights_by_month_plot <- flights_by_month %>% 
  ggplot(aes(x = month, y = count, group = 1)) +
  geom_point()+
  geom_line()

flights_by_month_plot 
  
# Add title
flights_by_month_plot +
  ggtitle("Number of Flights by Month from EWR in 2013")

# Add x and y labels
flights_by_month_plot +
  ggtitle("Number of Flights by Month from EWR in 2013")+
  xlab("Months")+
  ylab("Number of Flights")

# Sort by ascending order
flights_by_month %>% 
  ggplot(aes(x = reorder(month, count), y = count)) +
  geom_col()

# Sort by descending order
flights_by_month %>% 
  ggplot(aes(x = reorder(month, desc(count)), y = count)) +
  geom_col()

# Make graphs sit on x-axis
flights_by_month %>% 
  ggplot(aes(x = reorder(month, desc(count)), y = count)) +
  geom_col()+
  scale_y_continuous(expand = c(0, 0))

# Add titles
flights_by_month %>% 
  ggplot(aes(x = reorder(month, desc(count)), y = count)) +
  geom_col()+
  scale_y_continuous(expand = c(0, 0))+
  ggtitle("Number of Flights by Month from EWR in 2013")+
  xlab("Months")+
  ylab("Number of Flights")



