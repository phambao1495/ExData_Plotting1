# plot3.R

library(readr)
library(dplyr)

# download + unzip
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "data.zip", method = "libcurl")
unzip("data.zip")

# read + filter
dat <- read_delim(
  "household_power_consumption.txt", ";",
  escape_double = FALSE,
  col_types = cols(
    Date = col_date(format = "%d/%m/%Y"),
    Time = col_time(format = "%H:%M:%S")
  ),
  trim_ws = TRUE
) %>%
  filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# datetime
dat$dt <- as.POSIXct(paste(dat$Date, dat$Time))

# plot 3
png("plot3.png", width = 480, height = 480)

plot(dat$dt, dat$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering", col = "black")
lines(dat$dt, dat$Sub_metering_2, col = "red")
lines(dat$dt, dat$Sub_metering_3, col = "blue")

legend("topright", lty = 1, col = c("black","red","blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
