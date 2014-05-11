# A plot of global acitve power over time

# Open the file
png(filename = "plot2.png", width = 480, height = 480)

# Column names for the data
col_names = c("Date", "Time", "Global_active_power", "Global_reactive_power",
              "Voltage", "Global_intensity", "Sub_metering_1", 
              "Sub_metering_2", "Sub_metering_3")

# Read in the relevant data (Feb 1st and 2nd, 2007)
power <- read.table("../../data/household_power_consumption.txt", header=FALSE, 
                    skip=66636, sep=";", nrows=2880, quote="", 
                    col.names=col_names)

# Format the date data
dates <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")

# Make the plot
with(power, plot(dates, power$Global_active_power, 
                 ylab = "Global Active Power (kilowatts)", xlab = "",
                 type="n"))
lines(dates, power$Global_active_power)

# Close the file
dev.off()
