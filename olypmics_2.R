#Analysis of 120 years of summer Olympic Games
#How countries have performed historically
#Which nations took home the most medals--over 120 years and each year
#Participation of Male and Female athletes over time


#Import libraries
install.packages("gifski")
install.packages("png")

library(ggplot2)
library(gganimate)
library(dplyr)
library(ggthemes)
library(tidyverse)
library(gifski)
library(png)

olympics_data <- read_csv("OlympicData.csv")
olympics_data

#Bin the years
original <- c(1994,1998,2002,2006,2010,2014)
new <- c(1996,2000,2004,2008,2012,2016)
for (i in 1:length(original)) {
  olympics_data$Year <- gsub(original[i], new[i], olympics_data$Year)
}

olympics_data$Year <- as.integer(olympics_data$Year)

# No of athletes by sex
countsSex <- olympics_data %>% 
  group_by(Year, Sex) %>%
  summarize(Athletes = length(unique(ID)))
countsSex$Year <- as.integer(countsSex$Year)


# Athletes over time
ggplot(countsSex, aes(x=Year, y=Athletes, color=Sex, group=Sex)) +
  geom_point(size=2) +
  guides(color = guide_legend(reverse=TRUE)) +
  geom_line()  +
  transition_reveal(Year)+
  scale_color_manual(values=c("red4", "deepskyblue4")) +
  labs(x = "Year", y = "Athletes", 
       title="Male and Female athletes participation over time", 
       subtitle = "Olympic Games from 1896 to 2016")


