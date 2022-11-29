library(tidyverse)

#import DAX historical data.csv
dax <- read.csv("csv/DAX historical data.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

#import AEX historical data.csv
aex <- read.csv("csv/AEX historical data.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

dax$Price <- dax$Price / 20

#combine datas to dataframe, melt the data
temp <- inner_join(dax, aex, by = "Date")
names(temp) <- c("Date", "DAX", "AEX")
temp <- as.data.frame(temp)
temp_melt <- melt(temp, id.vars = "Date", variable.name = "TYPE")

#make the plot out of it
ggplot(data = temp_melt, mapping = aes(x = Date, y = value, group = variable)) +
    geom_line(aes(color = variable), size = 1.5) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(title = "DAX and AEX, Normalized") +
    geom_vline(xintercept="02/24/2022", linetype = 'dotted', color='red', size = 2)