# To Clear working environment
rm(list=ls())
graphics.off()

# Load libraries
library(plotly)
library(cowplot)
library(tidyverse)
library(gapminder)
library(nycflights13)


# Load gapminder data
data <- gapminder

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
  ggtitle("Life Expectancy vs. GDP per Capita\n") +
  xlab("GDP per Capita") +
  ylab("Average Life Expectancy")
  

# Make plot interactive by mapping year to frame aesthetic
p1 <- data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, color = continent, frame = year))+
  geom_point(aes(text = paste ("country:",country)))+ # add country 'text"
  scale_x_log10()+
  ggtitle("Life Expectancy vs. GDP per Capita") +
  xlab("GDP per Capita") +
  ylab("Average Life Expectancy")

p1

# Saving plots
ggsave(plot = p1, "gapminder.png", dpi = 600,
       height = 5, width = 7, units = "in")

# Use ggplotly to make it interactive
ggplotly(p1)


# Simple scatter plots ----------------------------------------------------

# Plotting life expectancy of European countries in 2007
data %>%
  filter(continent == "Asia" & year == 1992) %>% 
  ggplot(aes(x = lifeExp, y = reorder(country,lifeExp)))+
  geom_point()

# Reorder y values by lifeExp
life_plot <- data %>%
  filter(continent %in% c("Europe", "Africa") & year == 2007) %>% 
  ggplot(aes(x = lifeExp, y = reorder(country,lifeExp), color = continent))+
  geom_point()


life_plot+
  facet_wrap(~continent)


# Africa Life expectancy in 2007
data %>%
  filter(continent == "Africa" & year == "2007") %>% 
  ggplot(aes(x = lifeExp, y = reorder(country,lifeExp))) +
  geom_point()+
  ggtitle("Life Expetency of African Countries in 2007")+
  xlab("Life Expectancy") + ylab("Countries")


data %>%
  filter(year == 2002 & continent %in% c("Americas", "Europe")) %>% 
  ggplot(aes(x = lifeExp, y = reorder(country,lifeExp))) +
  geom_point()

# Gapminder GDP -----------------------------------------------------------

# 2007 data
data %>%
  filter(year == "2007") %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent))+
  geom_point()

# geom_jitter
data %>%
  filter(year == "2007") %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent))+
  geom_jitter()

# Adjust geom_jitter
data %>%
  filter(year == "2007") %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent))+
  geom_jitter(width = 0.2)

# Boxplot
data %>%
  filter(year == "2007") %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent))+
  geom_jitter(width = 0.2)+
  geom_boxplot()

# Adjust boxplot
data %>%
  filter(year == "2007") %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent))+
  geom_jitter(width = 0.2)+
  geom_boxplot(fill = NA)


# Violin plot
data %>%
  filter(year == "2007") %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent))+
  geom_jitter(width = 0.2)+
  geom_violin(fill = NA)

# Interactive plot
gdp_plot <- data %>%
  ggplot(aes(x = continent, y = gdpPercap, color = continent, frame = year)) +
  geom_jitter(width = 0.2)+
  geom_violin(fill = NA)

ggplotly(gdp_plot)


# US Dental Schools -------------------------------------------------------
dentalschools <- ("https://raw.githubusercontent.com/nguyens7/Rworkshop/master/Session_3/dentalschools.csv")

# Read .csv file
schools <- read_csv(dentalschools)

# Look at data structure
str(schools)

# Change USDentalSchools to factor
schools$USDentalSchools <- as.factor(schools$USDentalSchools)

# Plot schools
schools %>% 
  ggplot(aes(x = AverageDAT, y = AverageGPA)) +
  geom_point()

# Add title and label axes
schools %>% 
  ggplot(aes(x = AverageDAT, y = AverageGPA, color = USDentalSchools)) +
  geom_point() +
  ggtitle("US Dental School Average DAT and GPA") + # Title
  xlab("Average DAT Score") + # X axis
  ylab("Average GPA") # Y axis

# Remove legend
school_plot <- schools %>% 
  ggplot(aes(x = AverageDAT, y = AverageGPA, color = USDentalSchools))+
  geom_point()+
  ggtitle("US Dental School Average DAT and GPA")+
  xlab("Average DAT Score")+
  ylab("Average GPA")+
  guides(color = FALSE) #removes legend
  



#Annotate percentiles and add text
school_plot <- schools %>% 
  ggplot(aes(x = AverageDAT, y = AverageGPA, color = USDentalSchools))+
  geom_point()+
  ggtitle("US Dental School Average DAT and GPA")+
  xlab("Average DAT Score")+
  ylab("Average GPA")+
  guides(color = FALSE)+
  annotate("rect", xmin = 22, xmax = 23, ymin = 3.2, ymax = 3.85, alpha =0.1, fill = "red") +
  annotate("text", x = 22.5, y = 3.75, label = "98th Percentile")+
  annotate("rect", xmin = 19, xmax = 20, ymin = 3.2, ymax = 3.85, alpha =0.1, fill = "blue") +
  annotate("text", x = 19.5, y = 3.75, label = "75th Percentile")+
  annotate("rect", xmin = 17, xmax = 18, ymin = 3.2, ymax = 3.85, alpha =0.1, fill = "green") +
  annotate("text", x = 17.5, y = 3.75, label = "50th Percentile")

# Make it interactive
ggplotly(school_plot)


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



# Extra Credit ------------------------------------------------------------

# Add line segments
data %>%
  filter(continent == "Europe" & year == "2007") %>% 
  ggplot(aes(x = lifeExp, y = reorder(country,lifeExp))) +
  geom_point()+
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
               color = "grey50")+
  geom_point()

# Fix x axis  
data %>%
  filter(continent == "Europe" & year == "2007") %>% 
  ggplot(aes(x = lifeExp, y = reorder(country,lifeExp))) +
  geom_segment(aes(x = 70, 
                   xend = lifeExp, 
                   y = reorder(country,lifeExp), 
                   yend = reorder(country,lifeExp)),
               color = "grey50")+
  geom_point()+
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
                     limits = c(70, 84))+ 
  ggtitle("Life Expetency of European Countries in 2007")+
  xlab("Life Expectancy") + 
  ylab("Countries")

