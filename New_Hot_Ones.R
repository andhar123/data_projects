#Libraries
library(dplyr)
library(ggplot2)
options(scipen = 999)

# Data
episodes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-08-08/episodes.csv')
sauces <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-08-08/sauces.csv')
seasons <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-08-08/seasons.csv')


# Filter sauces only with word 'sauce' in name
spec_sauces <- sauces %>% 
  filter(grepl('sauce', sauce_name, ignore.case = T)) %>% 
  filter(!grepl('microsaucerie', sauce_name, ignore.case = T)) %>% 
  select(-sauce_number)

# Plot - All scoville sauce values by season
ggplot(spec_sauces, aes(season, scoville, fill = sauce_name)) + 
  geom_bar(stat = 'identity', position = 'dodge') + 
  labs(title = 'All Scoville Sauce Values By Season') +
  theme_classic() + theme(legend.position = 'none')



# Plot - Average scoville sauce value by season
avg_sauces <- spec_sauces %>% group_by(season) %>% 
  summarise(average_scoville = mean(scoville))

ggplot(avg_sauces, aes(season, average_scoville)) + 
  geom_bar(stat = 'identity', position = 'dodge', fill = 'dark red') + 
  labs(title = 'Average Scoville Sauce Value By Season') +
  theme_classic() + theme(legend.position = 'none')






