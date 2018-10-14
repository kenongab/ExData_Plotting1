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

#convert columns to appropriate data type and add new datetime column
feb <- feb %>% mutate(Date = dmy(Date), datetime = as.POSIXct(paste(Date, Time), format = '%Y-%m-%e %H:%M:%S'))

#opens PNG device and plots, saves PNG file into working directory
png(filename = "plot4.png")
plot.new()
par(mfcol = c(2,2))
with(feb, plot(datetime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power"))
with(feb, lines(datetime, Global_active_power))
with(feb, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(feb, lines(datetime, Sub_metering_1))
with(feb, lines(datetime, Sub_metering_2, col = "red"))
with(feb, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")
with(feb, plot(datetime, Voltage, type = "n", xlab = "datetime", ylab = "Voltage"))
with(feb, lines(datetime, Voltage))
with(feb, plot(datetime, Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power"))
with(feb, lines(datetime, Global_reactive_power))
dev.off()