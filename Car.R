library(ggmap)
library(tidyverse)

register_google(key = "AIzaSyAS6BInQYabkqEJ3M3DJq3EM6JQqKLF_9c")

#import car.csv
car <- read.csv("csv/car.csv", header = TRUE, sep = ",")

#convert it to dataframe
car <- as.data.frame(car)
car

car_data <- mutate_geocode(data = car, location = Address, source = 'google')
#use marker to show the location, and add label car$ABS
car_data_marker <- data.frame(car_data$lon, car_data$lat)
#use ggmap to show the map, and add geom_text to show the label. label is above the marker.
car_map <- get_googlemap('europe', maptype = 'roadmap', zoom = 1, markers = car_data_marker)
ggmap(car_map) + geom_text(data = car_data, aes(x = lon, y = lat),
    size = 4, label = car_data$ABS)


