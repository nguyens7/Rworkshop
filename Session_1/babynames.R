# Load libraries
library(babynames)
library(tidyverse)
library(cowplot)

# Load Babynames Dataset
babynames
df <- babynames
df

# Filter ------------------------------------------------------------------

michael <- df %>%
  filter(name == "Michael")

Mike <- df %>%
  filter(name == "Mike")

mary <- df %>%
  filter(name == "Mary")

mary %>%
  ggplot(aes(x = year, y = n, color = sex))+
  geom_line()

sean <- df %>%
  filter(name == "Sean")

sean_plot <- sean %>% 
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line()

sean_plot

shaun <- df %>%
  filter(name == "Shaun") %>%
  ggplot(aes(x = year, y = n, color = sex))+
  geom_line()

shaun

shawn <- df %>%
  filter(name == "Shawn")

shawn %>%
  ggplot(aes(x = year, y = n,color = sex))+
  geom_line()



df %>% 
  filter(name == "Keara" | name == "Bob" | name == "Anya")

df %>% 
  filter(name %in% c("Keara", "Bob", "Anya"))

# Filter multiple criteria ------------------------------------------------

variations <- df %>%
  filter(name == "Sean"|name == "Shaun"|name == "Shawn") # '|' = or  ',' = and

df %>% 
  filter(name %in% c("Sean","Shaun","Shawn"))

df %>%
  filter(name == "Sean"|name == "Shaun"|name == "Shawn" & year== "1980") 

df %>%
  filter(year== "1980" & name == "Sean"|year== "1980" & name == "Shaun"| year== "1980" & name == "Shawn") 

df %>%
  filter(year== "1980" & name %in% c("Sean","Shaun","Shawn"))


df %>%
  filter(name == "Sean"|name == "Bob"|name == "Betty") %>%
  ggplot(aes(x = year, y = n, color = name)) +
  geom_line()+
  facet_grid(~sex)

df %>%
  filter(name %in% c("Sean","Shaun","Shawn") & year == 1992)%>%
  group_by(year,name) %>%
  ggplot(aes(x = reorder(name,n), y = n, fill=name)) +
  geom_col()


variations <- df %>%
  filter(name %in% c("Sean","Shaun","Shawn"), year %in% 1990:2000)
 
df %>%
  filter(name == "Denise") %>%
  ggplot(aes(x = year,y = n, color = sex))+
  geom_line()+
  scale_y_continuous(expand=c(0,0))

taylor <- df %>%
  filter(name == "Taylor") %>%
  ggplot(aes(x = year, y = n, colour = sex))+
  geom_line()+
  scale_y_continuous(expand=c(0,0))+
  ggtitle("Taylor title plot")

taylor
  

df %>%
  filter(name == "Frankie") %>%
  ggplot(aes(x = year, y = n, colour = sex))+
  geom_line()


all.gender <- df %>%
  group_by(sex) %>%
  summarise(count = sum(n)) %>%
  ggplot(aes(x = sex, y = count, fill = sex))+
  geom_bar(stat = "identity")

names.1990s <- df %>%
  filter(year %in% 1990:2000) %>%
  group_by(name,sex) %>%
  summarize(count = sum(n)) %>%
  group_by(sex) %>%
  mutate(rank = min_rank(desc(count))) %>%
  filter(rank <= 5) %>%
  arrange(sex,rank)

  
df %>%
  filter(year %in% 1880:2015 & name %in% c("Ashley","Jessica","Emily",
                                         "Sarah","Samantha","Michael",
                                         "Christopher","Matthew","Joshua","Jacob"))%>%
  ggplot(aes(x = year, y = n, color = name))+
    geom_line()+
    facet_grid(~sex)
  
  
shared.names <- df %>%
  mutate(male = ifelse (sex == "M", n, 0), female = ifelse(sex == "F", n, 0)) %>%
  group_by(name) %>%
  summarize(Male = as.numeric(sum(male)), 
            Female = as.numeric(sum(female)),
            count = as.numeric(sum(n)),
            AvgYear = round(as.numeric(sum(year * n) / sum(n)),0)) %>%
  filter(Male > 30000 & Female > 30000)
 
shared.names


sarah <- df %>%
  filter(name == "Sarah") %>%
  group_by(year,sex) %>%
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line()


apple <- df %>%
  filter(name == "Apple") %>%
  group_by(year,sex,n) %>%
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line()

link <- df %>%
  filter(name == "Link") %>%
  group_by(year, sex, n) %>%
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line()

gender <- df %>%
  group_by(year,sex) %>%
  summarise(count= sum(n))

gender_plot <- gender %>%
  ggplot(aes(x = year, y = count, color = sex)) +
  geom_line(size = 2)+
  xlab("Year") +  # X axis label
  ylab("Number of People Born") +  # Y axis label  
  ggtitle("Number of Individuals Born\nIn the US Each Year (1880-2015)") + # Plot title
  scale_y_continuous(expand=c(0,0))


gender_plot + facet_grid(~sex)

r_workshop_names <- c("Anne-Sophie", "David", "Kyle","Keren","Nicholas", "Zoe", "Jacob", "Laura", "Siomara",
                      "Irving", "Kaitlyn", "Emily", "Kevin", "Faryal", "Justin", "Aaron", "Jose", "Kirti",
                      "Thomas", "Wei", "Chunqiu", "Kayla", "Hossein", "Pedro")

df %>% 
  filter( name %in% r_workshop_names) %>% 
  ggplot(aes(x = year , y = n, color = name))+
  geom_line()+
  facet_grid(~sex)

# Iris Data Set -----------------------------------------------------------
iris <- iris

iris %>% 
  ggplot(aes(x = Sepal.Length, y = Petal.Length, color = Species))+
  geom_point(size = 3)



# Diamonds Data Set -------------------------------------------------------

df1 <- diamonds

df1 %>%
  ggplot()+
  geom_point(aes(x = carat, y = price, color = cut))+
  facet_wrap(~cut)

df1 %>%
ggplot(aes(x = carat, y = price, color = cut)) +
  geom_point() +
  facet_grid(color~cut)


