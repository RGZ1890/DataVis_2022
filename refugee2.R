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
pie(head2017$Refugees.under.UNHCR.s.mandate, labels = head2017$Country.of.origin)

head2022 <- head(refugee2022, 10)
head2022
pie(head2022$Refugees.under.UNHCR.s.mandate, labels = head2022$Country.of.origin)
merged_temp <- merge(head2017, head2022, all = T)
merged_temp
library(ggplot2)


#make pie chart for refugees in 2017, with only top 3 countries has the name of the country
pie(merged_temp$Refugees.under.UNHCR.s.mandate.x, labels = merged_temp$Country.of.origin.x)

#make pie chart for refugees in 2022, with only top 3 countries has the name of the country
pie(merged_temp$Refugees.under.UNHCR.s.mandate.y, labels = merged_temp$Country.of.origin.y)