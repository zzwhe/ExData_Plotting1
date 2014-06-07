# Download file, unzip, read and assign the file to "datafile".
# If you can not download the file, you can get the file from the project, and save the file to your computer.

temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
datafile <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")
unlink(temp)

# Check the file first
head(datafile)
class(datafile$Date)
# Change "datafile$Date" to Date type
datafile$Date <- as.Date(datafile$Date, format = "%d/%m/%Y")  

# Subset the data and save the subset in file "thedata", and check the file briefly.
thedata <- datafile[datafile$Date >= "2007-02-01" & datafile$Date <= "2007-02-02", ] 
nrow(thedata)
names(thedata)

# Check the data class and adjust the class for analysis.
class(thedata$Global_active_power)
# Change the "factor" class to "numeric".
thedata$Global_active_power <- as.numeric(as.character(thedata$Global_active_power))

# Creat another column "DateTime", check the class of "DateTime", and adjust the class
thedata$DateTime <- paste(thedata$Date, thedata$Time)
class(thedata$DateTime)
# Change the "character" class to "POSIXlt"
thedata$DateTime <- as.POSIXlt(thedata$DateTime)

#Make the plot 2:
png(filename = "plot2.png", width = 480, height = 480)
par(mfrow = c(1,1), mar = c(4,4,2,2))
plot(thedata$DateTime, thedata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

