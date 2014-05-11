# A histogram of global active power

# Open the file
png(filename = "plot1.png", width = 480, height = 480)

# Column names for the data
col_names = c("Date", "Time", "Global_active_power", "Global_reactive_power",
              "Voltage", "Global_intensity", "Sub_metering_1", 
              "Sub_metering_2", "Sub_metering_3")

# Read in the relevant data (Feb 1st and 2nd, 2007)
power <- read.table("../../data/household_power_consumption.txt", header=FALSE, 
                    skip=66636, sep=";", nrows=2880, quote="", 
                    col.names=col_names)

# Make the histogram
hist(power$Global_active_power, col="red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# Close the file
dev.off()