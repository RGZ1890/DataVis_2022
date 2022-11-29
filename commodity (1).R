#import library needed
library(ggplot2)
library(dplyr)
library(readr)
library(reshape2)
library(reshape)
library(tidyr)
library(readr)


#import global_copper_2020-.csv, global_energy_2020-.csv, global_iron_2020-csv, global_natural_gas_2020-.csv, global_sunflower_oil_2020-.csv, global_wheat_2020-.csv
#read in the data
copper <- read.csv("csv/global_copper_2020-.csv")
energy <- read.csv("csv/global_energy_2020-.csv")
iron <- read.csv("csv/global_iron_2020-.csv")
gas <- read.csv("csv/global_natural_gas_2020-.csv")
sunflower <- read.csv("csv/global_sunflower_oil_2020-.csv")
wheat <- read.csv("csv/global_wheat_2020-.csv")

#change copper's variable to percentage
copper$copper_Glob <- copper$copper_Glob / 100
sunflower$sunfloweroil_Glob <- sunflower$sunfloweroil_Glob/5
#join the data
temp <- inner_join(copper, energy, by = "DATE")
temp <- inner_join(temp, iron, by = "DATE")
temp <- inner_join(temp, gas, by = "DATE")
temp <- inner_join(temp, sunflower, by = "DATE")
temp <- inner_join(temp, wheat, by = "DATE")
#temp <- inner_join(temp, currency_RUB, by = "DATE")
#temp <- inner_join(temp, currency_HRV, by = "DATE")

#rename the columns
names(temp) <- c("DATE", "copper/100", "energy", "iron ore", "natural gas", 
                 "sunflower oil/5", "wheat")

#melt the data
temp_melt <- melt(temp, id.vars = "DATE", variable.name = "TYPE")

#plot the data
ggplot(data = temp_melt, mapping = aes(x = DATE, y = value, group = variable)) + geom_line(aes(color=variable)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))

