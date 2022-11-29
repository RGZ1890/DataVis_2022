#import library needed
library(ggplot2)
library(dplyr)
library(readr)
library(reshape2)
library(reshape)
library(tidyr)
library(readr)


currency_UAH <- read_csv("csv/USD_UAH_day.csv")
currency_RUB <- read_csv("csv/USD_RUB_day.csv")
#US_RUS_import <- read_csv("U.S. Imports of Goods by Customs Basis from Russia.csv")
#US_UKR_import <- read_csv("U.S. Imports of Goods by Customs Basis from Ukraine.csv")

#divide currency_RUB by 1000
#currency_RUB$RUB <- currency_RUB$RUB / 2

#blend the data together
temp <- inner_join(currency_UAH, currency_RUB, by = "DATE")

#rename the columns
names(temp) <- c("DATE", "currency_UAH", "currency_RUB")

#convert temp to dataframe, melt the data
temp <- as.data.frame(temp)
temp_melt <- melt(temp, id.vars = "DATE", variable.name = "TYPE")

#plot the data, change the thickness of the line
#title will be: "Currency Exchange Rate, equivalent to 1 USD"
#flip the y-axis
ggplot(data = temp_melt, mapping = aes(x = DATE, y = 1 / value, group = variable)) +
    geom_line(aes(color=variable), size = 1.5) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(title = "Currency Exchange Rate, equivalent to 1 USD") +
    geom_vline(xintercept="02/25/2022", linetype = 'dotted', color='red', size = 1)