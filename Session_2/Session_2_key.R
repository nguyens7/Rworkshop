library(nycflights13)
library(tidyverse)

flights <- flights
weather <- weather

head(flights)  

may_9 <- flights %>% 
  filter(month == 5 & day == 9)

jan_feb <- flights %>% 
  filter(month %in% c("1", "2"))

flights %>% 
  filter(dest %in% c("SFO", "LAX"))

flights %>% 
  filter(arr_delay >60)

early_flights <- flights %>% 
  filter(sched_dep_time >= 2400 |
         sched_dep_time <= 600 )

flights %>% 
  arrange(month, day)

flights %>% 
  arrange(dest)

flights %>% 
  arrange(desc(air_time))

speed <- flights %>% 
  mutate(speed = distance/(air_time/60)) %>% 
  arrange(desc(speed))

flights %>% 
  filter(month == 11 & origin == "JFK") %>% 
  arrange(desc(dep_delay))

flights %>% 
  filter(origin == "LGA" & dest == "DTW") %>% 
  arrange(arr_delay)
  

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
  
  
weather_flights <- flights %>% 
  inner_join(weather)

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


