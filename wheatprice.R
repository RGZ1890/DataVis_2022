library(ggplot2)
library(dplyr)
library(readr)

copper <- read.csv("global_copper_2020-.csv")
copper

wheat <- read.csv("global_wheat_2020-.csv")
wheat

iron <- read.csv("global_iron_2020-.csv")

temp <- inner_join(copper, wheat, by = "DATE")
temp <- inner_join(temp, iron, by = "DATE")

names(temp) <- c("DATE", "copper", "wheat", "iron ore")
temp

library(reshape2)
library(reshape)
temp_melt <- melt(temp, id.vars = "DATE", variable.name = "TYPE")
temp_melt

#ggplot2.plot <- ggplot(temp_melt, aes(x = DATE, y = value, color = TYPE)) + geom_line() + theme_bw() + labs(title = "Global Commodity Prices", x = "Date", y = "Price (USD per metric ton)")
ggplot(data = temp_melt, mapping = aes(x = DATE, y = value, group = variable)) + geom_line(aes(color=variable))
#change graph1's x axis to be displayed in diagonal, and name it graph2
#graph2 = graph1 + theme(axis.text.x = element_text(angle = 45, hjust = 1))
