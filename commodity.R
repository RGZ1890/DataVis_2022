#import library needed
library(ggplot2)
library(dplyr)
library(readr)
library(reshape2)
library(reshape)
library(tidyr)

#import global_copper_2020-.csv, global_energy_2020-.csv, global_iron_2020-csv, global_natural_gas_2020-.csv, global_sunflower_oil_2020-.csv, global_wheat_2020-.csv
#read in the data
copper <- read.csv("global_copper_2020-.csv")
energy <- read.csv("global_energy_2020-.csv")
iron <- read.csv("global_iron_2020-.csv")
gas <- read.csv("global_natural_gas_2020-.csv")
sunflower <- read.csv("global_sunflower_oil_2020-.csv")
wheat <- read.csv("global_wheat_2020-.csv")

#change copper's variable to percentage
copper$PCOPPUSDM <- copper$PCOPPUSDM / 100
#join the data
temp <- inner_join(copper, energy, by = "DATE")
temp <- inner_join(temp, iron, by = "DATE")
temp <- inner_join(temp, gas, by = "DATE")
temp <- inner_join(temp, sunflower, by = "DATE")
temp <- inner_join(temp, wheat, by = "DATE")

#rename the columns
names(temp) <- c("DATE", "copper", "energy", "iron ore", "natural gas", "sunflower oil", "wheat")

#melt the data
temp_melt <- melt(temp, id.vars = "DATE", variable.name = "TYPE")

#plot the data
ggplot(data = temp_melt, mapping = aes(x = DATE, y = value, group = variable)) + geom_line(aes(color=variable)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))
