library(readr)
library(dplyr)

# get data
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

# plot 2
par(mfrow = c(1,1), mar = c(2,4,1,1))
plot(dat$dt, dat$Global_active_power, type = "l",
     ylab = "Global Active Power (Kilowatts)", xlab = "")

dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()
