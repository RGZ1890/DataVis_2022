#import necessary packages
library(tidyverse)
#import KOSPI Historical Data.csv and NASDAQ Composite Historical Data.csv
#Import data from KOSPI
kospi <- read.csv("csv/KOSPI Historical Data.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

#Import data from NASDAQ
nasdaq <- read.csv("csv/NASDAQ Composite Historical Data.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

#import data from euro Stoxx 50 Historical Data.csv
euro <- read.csv("csv/euro Stoxx 50 Historical Data.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

#make values even
nasdaq$Price <- nasdaq$Price / 5
euro$Price <- euro$Price / 1.5

#blend the data together
temp <- inner_join(kospi, nasdaq, by = "Date")
temp <- inner_join(temp, euro, by = "Date")

#rename the columns
names(temp) <- c("Date", "KOSPI", "NASDAQ", "EuroStoxx")

#convert temp to dataframe, melt the data
temp <- as.data.frame(temp)
temp_melt <- melt(temp, id.vars = "Date", variable.name = "TYPE")

#make the plot out of it
ggplot(data = temp_melt, mapping = aes(x = Date, y = value, group = variable)) +
    geom_line(aes(color = variable), size = 1.5) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(title = "KOSPI, NASDAQ(1/5), EuroStoxx(1/2) , relative") +
    geom_vline(xintercept="02/24/2022", linetype = 'dotted', color='red', size = 2)