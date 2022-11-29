#import libraries
library(ggplot2)
library(dplyr)
library(tidyr)

#import yearly gas production and make a pie chart
#load data
gas_production <- read.csv("csv/yearly gas production.csv", header = TRUE, sep = ",")

#change data so that each production value becomes a percentage of the total
gas_production <- gas_production %>%
    mutate(percentage = (Production / sum(Production)) * 100)

#Country with lower than 3% production is grouped into single row "Others" and summed
gas_production <- gas_production %>%
    group_by(Country) %>%
    summarise(Production = sum(Production)) %>%
    ungroup() %>%
    mutate(percentage = (Production / sum(Production)) * 100) %>%
    filter(percentage > 3) %>%
    mutate(Country = ifelse(percentage < 3, "Others", Country))

#make a pie chart by country, showing the percentage of production with country's name on it, including others appearing last
#make it descending order, but not including "Others". make russia red, with font size of 7
gas_production %>%
    arrange(desc(percentage)) %>%
    filter(Country != "Others") %>%
    ggplot(aes(x = "", y = percentage, fill = Country)) +
    geom_bar(width = 1, stat = "identity") +
    coord_polar("y", start = 0) +
    labs(title = "Gas Production by Country (lower than 3% excluded)", x = "", y = "") +
    geom_text(aes(label = paste0(Country, " ", round(percentage, 1), "%")), position = position_stack(vjust = 0.5), size = 7) +
    theme_void() +
    theme(legend.position = "none") +
    scale_fill_manual(values = c("Russia" = "red"))