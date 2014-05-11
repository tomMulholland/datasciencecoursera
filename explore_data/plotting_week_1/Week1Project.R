## Exploratory Data Analysis
## Week 1
## Course Project - Electric Power Consumption

setwd("/home/tom/scripts/gnuR/coursera/explore_data/w1")
if(!file.exists('data')){
    dir.create('data')
}
#file_url <- 
#  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%
#  2Fhousehold_power_consumption.zip"
#download.file(file_url, destfile = "./data/household_power.zip", 
#  method="curl")
#list.files('./data')
## Unzip the downloaded file

#library(data.table)
# power_data <- fread("./data/household_power_consumption.txt", 
#                     header=TRUE)
# power_data <- read.table("./data/household_power_consumption.txt", 
#                     sep=";", header=TRUE)
# power <- power_data[(power_data$Date=="1/2/2007") + 
#                         (power_data$Date == "2/2/2007"), ]
# indices <- c(which(power_data$Date == "1/2/2007"),
#              which(power_data$Date == "2/2/2007"))
# 
# rm(power_data)
col_names = c("Date", "Time", "Global_active_power", "Global_reactive_power",
              "Voltage", "Global_intensity", "Sub_metering_1", 
              "Sub_metering_2", "Sub_metering_3")
power <- read.table("./data/household_power_consumption.txt", header=FALSE, 
                    skip=66636, sep=";", nrows=2880, quote="", 
                    col.names=col_names)
# Plot 1
hist(power$Global_active_power, col="red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# Plot 2
dates <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")
with(power, plot(dates, power$Global_active_power, 
                 ylab = "Global Active Power (kilowatts)", xlab = "",
                 type="n"))
lines(dates, power$Global_active_power)

# Plot 3
with(power, plot(dates, power$Sub_metering_1, 
                 ylab = "Energy sub metering", xlab = "",
                 type="n"))
lines(dates, power$Sub_metering_1, col="black")
lines(dates, power$Sub_metering_2, col="red")
lines(dates, power$Sub_metering_3, col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot 4
par(mfrow = c(2, 2))
par(mar = c(4, 4, 3, 3))
with(power, plot(dates, power$Global_active_power, 
                 ylab = "Global Active Power", xlab = "",
                 type="n", ps=12))
lines(dates, power$Global_active_power)
################################
with(power, plot(dates, power$Voltage, 
                 ylab = "Voltage", xlab = "datetime",
                 type="n", ps=12))
lines(dates, power$Voltage)
################################
with(power, plot(dates, power$Sub_metering_1, 
                 ylab = "Energy sub metering", xlab = "",
                 type="n"))
lines(dates, power$Sub_metering_1, col="black")
lines(dates, power$Sub_metering_2, col="red")
lines(dates, power$Sub_metering_3, col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n")
################################
with(power, plot(dates, power$Global_reactive_power, 
                 ylab = "Global_reactive_power", xlab = "datetime",
                 type="n"))
lines(dates, power$Global_reactive_power)
