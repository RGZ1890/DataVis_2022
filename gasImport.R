library(tidyverse)
#import package to use pie3D
library(plotrix)

#import gas_country.csv
gas_country <- read.csv("csv/gas_country.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

#convert each Export value to percentage
gas_country$Export <- gas_country$Export / sum(gas_country$Export) * 100

#if the Export value is less than 5%, then delete it
gas_country <- gas_country[gas_country$Export > 5,]

#make gas_country as descending order
gas_country <- gas_country[order(-gas_country$Export),]

#make a 3d pie chart out of it, with the percentage written with each country in font size 10
pie3D(gas_country$Export, labels = paste(gas_country$Country, round(gas_country$Export, 1), "%", sep = " "),
    main = "Gas Import by Country(<5% excluded)", 
    radius = 1, explode = 0.1, cex = 0.8, col = rainbow(length(gas_country$Export)), labelcex = 2)