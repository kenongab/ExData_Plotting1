#load required packages
library(dplyr)
library(readr)
library(lubridate)
library(ggplot2)

#read table into R and subset February 1-2, 2007 data only
hpc <- read_delim("household_power_consumption.txt", ";", na = c("?"), col_types = cols(
     Date = col_character(),
     Time = col_time(format = '%H:%M:%S'),
     Global_active_power = col_double(),
     Global_reactive_power = col_double(),
     Voltage = col_double(),
     Global_intensity = col_double(),
     Sub_metering_1 = col_double(),
     Sub_metering_2 = col_double(),
     Sub_metering_3 = col_double()))
feb <- hpc[hpc$Date == '1/2/2007' | hpc$Date == '2/2/2007',]

#convert columns to appropriate data type
feb <- feb %>% mutate(Date = dmy(Date))


#opens PNG device and plots histogram, saves PNG file into working directory
png(filename = "plot1.png")
plot.new()
with(feb, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
dev.off()