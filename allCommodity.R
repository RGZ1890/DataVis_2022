library(tidyverse)

#import day_Brent Oil Futures Historical Data.csv
brent <- read.csv("csv/day_Brent Oil Futures Historical Data.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
#import day_Crude Oil WTI Futures Historical Data.csv
wti <- read.csv("csv/day_Crude Oil WTI Futures Historical Data.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
#import day_Natural Gas Futures Historical Data.csv
naturalGas <- read.csv("csv/day_Natural Gas Futures Historical Data.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

naturalGas$Price <- naturalGas$Price * 7 + 55

#blend the data together
temp <- inner_join(brent, wti, by = "Date")
temp <- inner_join(temp, naturalGas, by = "Date")

#rename the columns
names(temp) <- c("Date", "Brent", "WTI", "NaturalGas")

#convert temp to dataframe, melt the data
temp <- as.data.frame(temp)
temp_melt <- melt(temp, id.vars = "Date", variable.name = "TYPE")

#make the plot out of it
ggplot(data = temp_melt, mapping = aes(x = Date, y = value, group = variable)) +
    geom_line(aes(color = variable), size = 1.5) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(title = "Brent, WTI, NaturalGas, relative") +
    geom_vline(xintercept="02/24/2022", linetype = 'dotted', color='red', size = 2) + 
    geom_vline(xintercept="05/02/2022", linetype = 'dotted', color='blue', size = 2) +
    geom_vline(xintercept="10/18/2022", linetype = 'dotted', color='blue', size = 2)