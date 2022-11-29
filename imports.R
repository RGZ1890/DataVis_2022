#import needed packages
library(tidyverse)

#import U.S. Imports of Goods by Customs Basis from Russia.csv and 
#U.S. Imports of Goods by Customs Basis from Ukraine.csv
#Import data from Russia
importRus <- read.csv("csv/U.S. Imports of Goods by Customs Basis from Russia.csv",
    header = TRUE, sep = ",", stringsAsFactors = FALSE)


#Import data from Ukraine
importUkr <- read.csv("csv/U.S. Imports of Goods by Customs Basis from Ukraine.csv",
    header = TRUE, sep = ",", stringsAsFactors = FALSE)

#blend the data together
temp <- inner_join(importRus, importUkr, by = "DATE")

#rename the columns
names(temp) <- c("DATE", "importRus", "importUkr")

#convert temp to dataframe, melt the data
temp <- as.data.frame(temp)
temp_melt <- melt(temp, id.vars = "DATE", variable.name = "TYPE")

#make the plot out of it
ggplot(data = temp_melt, mapping = aes(x = DATE, y = value, group = variable)) +
    geom_line(aes(color = variable), size = 1.5) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(title = "U.S. Imports of Goods by Customs Basis from Russia and Ukraine") + 
    geom_vline(xintercept="2022.3.1", linetype = 'dotted', color='red', size = 1)