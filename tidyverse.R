##1.select column
library(tidyverse)
mtcars %>% summary()  
mtcars %>% 
  select(mpg, hp, am, gear) %>%
  filter((hp < 100 & am ==0) | (gear == 5 & am == 1) ) %>%
  arrange(desc(hp)) %>%
  mutate(hp2 = hp*2, owner = "Me") %>%
  summarise(avg_hp = mean(hp), sd_hp = sd(hp))

mtcars %>%
  group_by(am,gear) %>%
  summarise(mean(hp),sd(hp),max(hp),min(hp),total_car = n())

mtcars %>%
  count(am) %>%
  mutate(total_car = n/sum(n)) -> result

result
