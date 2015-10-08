# R script to create plot 4 for HW 1 for Exploratory Data Analysis
#
# This script assumes that the txt file has been downloaded and unziped. If that
# is not the case, simply execute the following code, removing the '#' symbols:
#       fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#       download.file(fileURL, destfile = "./household_power_consumption.zip", method = "curl")
#       unzip("./household_power_consumption.zip")
#
#       #Capture the time of the download
#       dateDownloaded <- date()

# First, read in the data from a local folder
library(data.table)
library(lubridate)
DT <- fread("./household_power_consumption.txt", sep = ";", na.strings = "?", 
            header = TRUE)


# Convert the date columns to be readable
DT$Date <- as.Date(DT$Date, "%d/%m/%Y")


# Subset to just the data we want to work with
DTsub <- subset(DT, Date == "2007-02-01" | Date == "2007-02-02")

# Make a timestamp column
DTsub$datetime <- paste(DTsub$Date, DTsub$Time)

# Convert the time column to be readable
DTsub$Time <- parse_date_time(DTsub$datetime, "%y%m%d %H%M%S")

# Open the graphics device with the name and size
png(filename = "plot4.png", 
    width = 480, 
    height = 480, 
    units = "px")

# Create the 2 x 2 matrix for the set of plots
par(mfrow = c(2, 2))

# Plot the first, upper left plot
plot(DTsub$Time, DTsub$Global_active_power, 
     xlab = "",
     ylab = "Global Active Power",
     type = "l")

# Plot the second, upper right plot
plot(DTsub$Time, DTsub$Voltage, 
     xlab = "datetime",
     ylab = "Voltage",
     type = "l")

# Plot the third, lower left plot
plot(DTsub$Time, DTsub$Sub_metering_1, 
     xlab = "",
     ylab = "Energy sub metering",
     type = "l")
par(new = T)
lines(DTsub$Time, DTsub$Sub_metering_2, 
      col = "red")
par(new = T)
lines(DTsub$Time, DTsub$Sub_metering_3, 
      col = "blue")
legend("topright", 
       lwd = 1,
       box.lwd = 0,
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot the fourth, lower right plot
plot(DTsub$Time, DTsub$Global_reactive_power, 
     xlab = "datetime",
     ylab = "Global_reactive_power",
     type = "l")

# Close the graphic device
dev.off()