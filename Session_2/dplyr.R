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

flights %>%
  filter(month == "2")

# May 9th flights
flights %>% 
  

# jan feb flights
flights %>% 
  
# Flights to LAX and SFO
flights %>% 
  
# Flights delayed by >60 min
flights %>% 
  
# Flights that departed between 12am and 6am
flights %>% 
  

# Select ------------------------------------------------------------------

flights_small <- flights %>%
  select(year:carrier)

# Rename ------------------------------------------------------------------

flights1 <- flights %>% 
  rename(date_time_hour = time_hour)
 

# Arrange -----------------------------------------------------------------

flights %>%
  arrange(month, day, origin, dest)
  

# Mutate ------------------------------------------------------------------

# Computer mph from distance and air_time columns
flights1 <- flights %>%

# Longest flight delay from JFK in November
flights2 <- flights %>%

# LGA flights that arrived early to DTW
flights3 <- flights %>%


# Group by and Summarise --------------------------------------------------

flights %>%
  group_by(origin,month,day) %>% 
  summarize(Number_of_flights = length(origin))


# Joins -------------------------------------------------------------------
# make sure you have common column names in the dataframes you want to join
# or you will have to specify


# Inner join returns matches from flights and weather
weather_flights <- flights %>% 
  inner_join(weather, by = "time_hour") # both the flights and weather dataframes have a 'time_hour' column


# Left join returns ALL flights and matching weather
left_weather_flights <- flights %>%
  left_join(weather, by = "time_hour")



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

# Calculates the number of flights for each carrier to LAX and SFO for the three airports
flights %>% 
  filter(dest %in% c("LAX", "SFO")) %>% 
  group_by(month,dest,carrier,origin) %>% 
  summarise(n = length(month)) %>% 
  ggplot(aes(x = month, y = n, color = carrier, group = carrier, shape = dest))+
  geom_point(size = 4)+
  geom_line(size = 2)+
  facet_grid(origin~dest)

