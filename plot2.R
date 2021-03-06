# by Marc
# Last modified: 03.03.2015

# Set the different directories for the files
home <- getwd()

# Read the list of variable labels
variables <- c(read.table(file.path(home, "household_power_consumption.txt"), sep = ";", 
                          nrows = 1, stringsAsFactors = FALSE))

# Read the list of data from the 1/2/2007 00:00:00 until the 2/2/2007 23:59:00
data <- read.table(file.path(home, "household_power_consumption.txt"), header = FALSE, sep = ";", 
                   skip = 66637, nrows = 2880, col.names = unlist(variables), na.strings = "?")

# Merges the Date and Time columns and transforms them into date format. Finally removes the Time 
# column
data$Date <- paste(data$Date, data$Time, sep =" ")
data$Date <- strptime(data$Date, format = "%d/%m/%Y %H:%M:%S", tz = "UTC")
data <- data[, -2]

# Creates a png file
png(file="plot2.png", width = 480, height = 480, units = "px")

# Creates the Plot2
plot(data$Date, data$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Write to the png file
dev.off()
