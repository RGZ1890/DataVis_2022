library(tidyverse)
#import car.csv
car <- read.csv("csv/car.csv", header = TRUE, sep = ",")

#convert it to dataframe
car <- as.data.frame(car)


#barplot it, with text on top. x is the Company, y is the ABS. set it as descending order.
#text size is 5. title is "Loss of net worth, in -%".
#use random colors with legend. swap the legend position to the right and invert y axis.
pal = colorRampPalette(c("green", "red"))
ggplot(car, aes(x = reorder(Company, -ABS), y = ABS, fill = ABS)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = ABS), size = 5, vjust = -0.5) +
  labs(title = "Loss of net worth, in -%") +
  scale_fill_gradientn(colours = pal(10)) +
  theme(legend.position = "right") +
  coord_flip()