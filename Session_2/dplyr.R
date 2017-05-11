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

may_9 <- flights %>% 
  filter(month == "5" & day == "9")

jan_feb <- flights %>% 
  filter(month %in% c("1","2"))

flights %>% 
  filter(dest %in% c("LAX","SFO"))

flights %>% 
  filter(arr_delay>60)

early_flights <- flights %>% 
  filter(sched_dep_time >= 2400 | # | is 'or' , is 'and' & is 'and'
         sched_arr_time <= 600)

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

speed <-flights %>%
  mutate( mph = distance/ (air_time/60)) %>% 
  arrange(desc(mph))

flights %>%
  filter(month == "11" & origin == "JFK") %>% 
  arrange(desc(dep_delay))

flights %>%
  filter(origin == "LGA" & dest == "DTW") %>% 
  arrange(arr_delay)



# Group by and Summarise --------------------------------------------------

flights %>% 
  filter(month == 12) %>% 
  group_by(origin) %>% 
  summarise(N_flights = length(flight))

flights %>% 
  group_by(origin) %>% 
  summarise(N_airlines = n_distinct(carrier))

flights %>% 
  filter(origin == "EWR" & carrier == "UA" & dest == "ORD") %>%
  summarise(N_flights = length(flight))
  


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

# Run all these before you run line 124-131
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

