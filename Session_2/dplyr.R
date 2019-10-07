# Load libraries
library(tidyverse)
library(nycflights13)

# Load in data from nycflights13
flights <- flights
weather <- weather

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

flights %>% 
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

# Most flights in December
Dec_flights <- flights %>% 
  
  
# NYC airport with most airlines
Most_airlines <- flights %>% 
  
# Number of UA flights departing JFK to ORD
UA_JFK_ORD <- flights %>% 



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


