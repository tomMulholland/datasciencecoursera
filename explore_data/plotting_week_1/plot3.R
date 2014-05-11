# A plot of global active power in different areas of the house

# Open the file
png(filename = "plot3.png", width = 480, height = 480)

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
with(power, plot(dates, power$Sub_metering_1, 
                 ylab = "Energy sub metering", xlab = "",
                 type="n"))
lines(dates, power$Sub_metering_1, col="black")
lines(dates, power$Sub_metering_2, col="red")
lines(dates, power$Sub_metering_3, col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close the file
dev.off()