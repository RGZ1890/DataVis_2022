#import RTSI Historical Data.csv and PFTS Historical Data.csv, plot it using ggplot
library(tidyverse)
library(readr)
library(reshape)
library(readr)
library(plotly)
library(dygraphs)
library(xts)

rtsi <- read.csv("csv/RTSI Historical Data.csv")
pfts <- read.csv("csv/PFTS Historical Data.csv")
#change the date format
rtsi$Date <- as.Date(rtsi$Date, format = "%m.%d.%Y")
pfts$Date <- as.Date(pfts$Date, format = "%m.%d.%Y")
#make the interactive plot using plotly and xts
rtsi_xts <- xts(rtsi$Price, order.by = rtsi$Date)
pfts_xts <- xts(pfts$Price, order.by = pfts$Date)

rtsi_pfts <- cbind(rtsi_xts, pfts_xts)
colnames(rtsi_pfts) <- c("RTSI", "PFTS")
head(rtsi_pfts)

dygraph(rtsi_pfts) %>% dyRangeSelector()
