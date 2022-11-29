#import library needed
library(ggplot2)
library(dplyr)
library(readr)
library(reshape2)
library(reshape)
library(tidyr)

#import global_copper_2020-.csv, global_energy_2020-.csv, global_iron_2020-csv, global_natural_gas_2020-.csv, global_sunflower_oil_2020-.csv, global_wheat_2020-.csv
#read in the data
refugee2022 <- read.csv("csv/population2022_.csv")
refugee2017 <- read.csv("csv/population2017_.csv")
head2017 <- head(refugee2017, 10)
head2017
pie(head2017$Refugees.under.UNHCR.s.mandate,
    labels = head2017$Country.of.origin)

head2022 <- head(refugee2022, 10)
head2022
pie(head2022$Refugees.under.UNHCR.s.mandate,
    labels = head2022$Country.of.origin)
merged_temp <- merge(head2017, head2022, all = TRUE)
merged_temp
library(ggplot2)


#plot it with country's name out of the chart. adjust font size to 10. round it up to 1000, paste k behind
ggplot(data = merged_temp, aes(x = " ", y = Refugees.under.UNHCR.s.mandate,
        group = Country.of.origin, colour = Country.of.origin, fill = Country.of.origin)) +
    geom_bar(width = 1, stat = "identity") +
    coord_polar("y", start = 0) +
    facet_grid(. ~ Year) + theme_void() +
    scale_fill_manual(values = c("Ukraine" = "cyan")) +
    geom_text(aes(label = paste0(Country.of.origin, " ",
        round(Refugees.under.UNHCR.s.mandate / 1000, 0), "k")), size = 5,
        position = position_stack(vjust = 0.5)) +
    theme(legend.position = "none")

