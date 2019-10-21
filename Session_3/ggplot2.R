# Load libraries
library(plotly)
library(tidyverse)
library(gapminder)
library(nycflights13)


# Load gapminder data
data <- gapminder


# ggplot
data %>% 
  ggplot()


data %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp))

# Basic scatter plot
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# Adjust the alpha to see overlap
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 1/10)

# Flip axes easily with 'coord_flip()'
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  coord_flip()

# Adjust the x axis scale
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10()

# Map population to a size aesthetic
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10()

# Map continent to size aesthetic
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, color = continent)) +
  geom_point() +
  scale_x_log10()

# Facet data by year
plot <-  data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, color = continent)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~year)

plot

# Easily add titles and label axes
plot + 
  labs(title = "Life Expectancy vs. GDP per Capita\n",
       x = "GDP per Capita",
       y = "Average Life Expectancy")

  

# Make plot interactive by mapping year to frame aesthetic
p1 <- data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, color = continent, frame = year)) +
  geom_point(aes(text = paste ("country:",country))) + # add country 'text"
  scale_x_log10() +
  labs(title = "Life Expectancy vs. GDP per Capita\n",
       x = "GDP per Capita",
       y = "Average Life Expectancy")
p1

# Saving plots
ggsave(plot = p1, "gapminder.png", dpi = 600,
       height = 5, width = 7, units = "in")

# Use ggplotly to make it interactive
ggplotly(p1)


# Simple scatter plots ----------------------------------------------------

# Asia Life Expectancy in 1992
data %>% 


# Africa and Europe Life expectancy in 2007
data %>%


# GDP of Americas and Europe in 2002
data %>%
  

# GDP of each continent in 2007
  
data %>% 
  group_by(continent) %>% 
  summarize()

# Gapminder GDP -----------------------------------------------------------

# 2007 data
data %>%
  filter(year == "2007") %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent)) +
  geom_point()

# geom_jitter
data %>%
  filter(year == "2007") %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent)) +
  geom_jitter()

# Adjust geom_jitter
data %>%
  filter(year == "2007") %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent)) +
  geom_jitter(width = 0.2)

# Boxplot
data %>%
  filter(year == "2007") %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent)) +
  geom_jitter(width = 0.2)+
  geom_boxplot()

# Adjust boxplot
data %>%
  filter(year == "2007") %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent)) +
  geom_jitter(width = 0.2) +
  geom_boxplot(fill = NA)


# Violin plot
data %>%
  filter(year == "2007") %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent)) +
  geom_jitter(width = 0.2) +
  geom_violin(fill = NA)

# Adjust alpha
data %>%
  filter(year == "2007") %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent)) +
  geom_jitter(width = 0.2, alpha = 0.5) +
  geom_violin(fill = NA)

# Interactive plot
gdp_plot <- data %>%
  ggplot(aes(x = continent, y = gdpPercap, color = continent, frame = year, id = country)) +
  geom_jitter(width = 0.2, alpha = 0.5) 


ggplotly(gdp_plot)


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
  geom_point() +
  geom_line()


# make 'month' a "categorical" factor column
flights_by_month$month <-  as.factor(flights_by_month$month)

# Since we have only one observation, make group = 1 to connect the points
flights_by_month %>% 
  ggplot(aes(x = month, y = count, group = 1)) +
  geom_point() +
  geom_line()

# Make this into a plot object
flights_by_month_plot <- flights_by_month %>% 
  ggplot(aes(x = month, y = count, group = 1)) +
  geom_point() +
  geom_line()

flights_by_month_plot 
  
# Add title
flights_by_month_plot +
  labs(title = "Number of Flights by Month from EWR in 2013")

# Add x and y labels
flights_by_month_plot +
  labs(title = "Number of Flights by Month from EWR in 2013",
       x = "Months",
       y = "Number of Flights")

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
  geom_col() +
  scale_y_continuous(expand = c(0, 0))

# Add titles
flights_by_month %>% 
  ggplot(aes(x = reorder(month, desc(count)), y = count)) +
  geom_col() +
  scale_y_continuous(expand = c(0, 0)) +
  labs(title = "Number of Flights by Month from EWR in 2013",
       x = "Months",
       y = "Number of Flights")



# Extra Credit ------------------------------------------------------------

# Add line segments
data %>%
  filter(continent == "Europe" & year == "2007") %>% 
  ggplot(aes(x = lifeExp, y = reorder(country,lifeExp))) +
  geom_point() +
  geom_segment(aes(x = 70, xend = lifeExp, 
                   y = country , yend = country), color = "grey50")

# Order matters, move geom_point after geom_segment
data %>%
  filter(continent == "Europe" & year == "2007") %>% 
  ggplot(aes(x = lifeExp, y = reorder(country,lifeExp))) +
  geom_segment(aes(x = 70, 
                   xend = lifeExp, 
                   y = reorder(country,lifeExp), 
                   yend = reorder(country,lifeExp)),
               color = "grey50") +
  geom_point()

# Fix x axis  
data %>%
  filter(continent == "Europe" & year == "2007") %>% 
  ggplot(aes(x = lifeExp, y = reorder(country,lifeExp))) +
  geom_segment(aes(x = 70, 
                   xend = lifeExp, 
                   y = reorder(country,lifeExp), 
                   yend = reorder(country,lifeExp)),
               color = "grey50") +
  geom_point() +
  scale_x_continuous(expand = c(0, 0), # removes gap on x axis
                     limits = c(70, 84)) # defines x axis

# Add labels
data %>%
  filter(continent == "Europe" & year == "2007") %>% 
  ggplot(aes(x = lifeExp, y = reorder(country,lifeExp))) +
  geom_segment(aes(x = 70, 
                   xend = lifeExp, 
                   y = reorder(country,lifeExp), 
                   yend = reorder(country,lifeExp)),
               color = "grey50") +
  geom_point() +
  scale_x_continuous(expand = c(0, 0),
                     limits = c(70, 84)) +
  labs(title = "Life Expetency of European Countries in 2007",
       x = "Life Expectancy",
       y = "Countries")


