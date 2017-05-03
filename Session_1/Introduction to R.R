# To Clear working environment
rm(list=ls())
graphics.off()

# Libraries ---------------------------------------------------------------

library(tidyverse)
library(cowplot)
library(broom)

file <- "https://raw.githubusercontent.com/nguyens7/nguyens7.github.io/master/data/Antibiotics.csv"
data <- read_csv(file)

data  

dim(data)
head(data)

# Data munging ------------------------------------------------------------

# Making wide format into long format
data2 <- data %>%
  gather(Bacteria, Count, 2:10)

# Separate the Bacteria Column into Experiment and Organism
data3 <- data2 %>% 
  separate(Bacteria, into=c("Experiment","Organism", sep = "_")) %>% 
  select(-`_`)

# Make the Treatment and Organism columns as categorical 'factors'
data3$Treatment <- as.factor(data3$Treatment)
data3$Organism <- as.factor(data3$Organism)

data3

# write_csv(data3,"long.csv")

# Average within each experimental replicate ------------------------------

data4 <- data3 %>% 
  group_by(Organism, Treatment, Experiment) %>% 
  summarise( N = length(Count),
          mean = mean(Count),
            sd = sd(Count),
            se = sd/sqrt(N))
data4

# write_csv(data4,"experimental_summary.csv")
# Average all the experiments ---------------------------------------------

data5 <- data4 %>% 
 group_by(Organism,Treatment) %>% 
  summarise( avg_N   = length(mean),
             average = mean(mean),
             avg_sd  = sd(mean),
             avg_se  = avg_sd/sqrt(avg_N))
data5  

# write_csv(data5,"final_summary.csv")

# Graphing ----------------------------------------------------------------

# Boxplot of all data 
boxplot <- data3 %>% 
  group_by(Treatment, Organism) %>% 
  ggplot(aes(x = Organism, y = Count, color = Organism))+
  geom_boxplot(colour="black", fill=NA) + 
  geom_point(position= 'jitter', size=2) +
  ylab("\nColony Count\n") + # Y axis label
  ggtitle("Effect of Antibiotic on Bacterial Growth") + #title
  facet_wrap(~Treatment)

boxplot

# ggsave("boxplot.png")

# Bar graph of experiments
Experimental_Replicates <- data4 %>% 
  ggplot(aes(x=Organism,y=mean,fill=Treatment))+
  geom_col(position="dodge")+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.4, 
                size=0.8, colour="black", position=position_dodge(.9)) + #error bars
  scale_y_continuous(expand=c(0,0))+ #set bottom of graph
  xlab("Organism") + # X axis label
  ylab("\nColony Count\n") + # Y axis label
  ggtitle("Effect of Antibiotic on Bacterial Growth")+ #title
  facet_wrap(~Experiment)

Experimental_Replicates

# Final graph
Final_plot <- data5 %>% 
  ggplot(aes(x=Organism,y=average,fill=Treatment))+
  geom_col(position="dodge")+
  geom_errorbar(aes(ymin=average-avg_se, ymax=average+avg_se), width=.4, 
                size=0.8, colour="black", position=position_dodge(.9)) + #error bars
  scale_y_continuous(expand=c(0,0))+ #set bottom of graph
  xlab("Organism") + # X axis label
  ylab("\nColony Count\n") + # Y axis label
  ggtitle("Effect of Antibiotic on Bacterial Growth")

Final_plot


# Statisical Analysis -----------------------------------------------------

# Parametric Test
shapiro <- shapiro.test(data3$Count)
tidy(shapiro)
# Fail to reject Ho -> data is normal

# ANOVA
ANOVA <- aov(mean~(Organism*Treatment), data=data4)
tidy(ANOVA)

# Tukey HSD
HSD <- TukeyHSD(ANOVA)
tukey <- tidy(HSD)
tukey

# Aggregate significant results
sig.tukey <- tukey %>% 
  filter(adj.p.value<0.05) %>% 
  arrange(adj.p.value)
sig.tukey
