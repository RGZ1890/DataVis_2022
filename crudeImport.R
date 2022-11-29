library(tidyverse)

#import crudeImport.csv
crudeImport <- read.csv("csv/crudeImport.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

#convert each Import value to percentage
crudeImport$Import <- crudeImport$Import / sum(crudeImport$Import) * 100

#if the Import value is less than 5%, then delete it
crudeImport <- crudeImport[crudeImport$Import > 5,]

#make crudeImport as descending order
crudeImport <- crudeImport[order(-crudeImport$Import),]

#all country except Germany and Netherlands are summed into "Others"
crudeImport$Country[crudeImport$Country != "Germany" & crudeImport$Country != "Netherlands"] <- "Others"

#combine all 'Others' into one
crudeImport <- aggregate(Import ~ Country, data = crudeImport, sum)

#make a 3d pie chart out of it, with the percentage written with each country in font size 10,
#color germany as red, netherland as yellow, and the rest as grey
pie3D(crudeImport$Import, labels = paste(crudeImport$Country, round(crudeImport$Import, 1), "%", sep = " "),
    main = "Crude Oil Import by Country(<5% excluded)",
    radius = 1, explode = 0.1, cex = 0.8, col = c("red", "yellow", "grey"), labelcex = 2)