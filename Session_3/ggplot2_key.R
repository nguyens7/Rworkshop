library(tidyverse)
library(gapminder)


# Simple scatter plots ----------------------------------------------------

# Asia Life Expectancy in 1992
data %>% 
  filter(continent == "Asia", year == 1992) %>% 
  ggplot(aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_point()
  
  # Africa and Europe Life expectancy in 2007
data %>%
    filter(continent %in% c("Europe", "Africa") &
             year == 2007) %>% 
    ggplot(aes( x= lifeExp, y = reorder(country, lifeExp),
                color = continent)) +
    geom_point() +
    facet_wrap(~continent)
  
  
  # GDP of Americas and Europe in 2002
data %>%
    filter(continent %in% c("Americas", "Europe") &
           year == 2002) %>% 
    ggplot(aes(x = gdpPercap, y = reorder(country, gdpPercap), color = continent)) +
    geom_point()
  
  
 # GDP of each continent in 2007

data %>% 
  filter(year == 2007) %>% 
  group_by(continent) %>% 
  summarize(GDP = mean(gdpPercap)) %>% 
  ggplot(aes(x = continent, y = GDP)) +
  geom_col()


# Explicitly change the order of 'categorical' factors
data %>% 
  filter(year == 2007) %>% 
  group_by(continent) %>% 
  summarize(GDP = mean(gdpPercap)) %>% 
  mutate(continent = factor(continent, levels = c("Oceania", "Africa", "Asia", "Europe"))) %>% 
  ggplot(aes(x = continent, y = GDP)) +
  geom_col()
  

