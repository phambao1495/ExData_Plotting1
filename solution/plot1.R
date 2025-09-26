# Load libs
library(readr)
library(dplyr)

# Download data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "data.zip", method = "auto")

# Read data
data <- read_delim(
  "data.zip", ";", 
  escape_double = FALSE,
  col_types = cols(
    Date = col_date(format = "%d/%m/%Y"),
    Time = col_time(format = "%H:%M:%S")
  ),
  trim_ws = TRUE
)

# Filter dates
df <- data %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02")

# Add datetime
df$DateTime <- as.POSIXct(paste(df$Date, df$Time))

# Plot
par(mfrow = c(1,1), mar = c(4,4,1,1))
hist(df$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (Kilowatts)")

# Save png
dev.print(png, "plot1.png", width = 480, height = 480)
dev.off()
