# Download file, unzip, read and assign the file to "datafile".
# If you can not download the file, you can get the file from the project, and save the file to your computer.

temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
datafile <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")
unlink(temp)

# Check the file first
head(datafile)
class(datafile$Date)
# Change "Date" to Date type
datafile$Date <- as.Date(datafile$Date, format = "%d/%m/%Y")  

# Subset the data and save the subset in file "thedata", and check the file briefly.
thedata <- datafile[datafile$Date >= "2007-02-01" & datafile$Date <= "2007-02-02", ] 
nrow(thedata)
names(thedata)

# Check the data class and adjust the class for analysis.
class(thedata$Sub_metering_1)
class(thedata$Sub_metering_2)
class(thedata$Sub_metering_3)
thedata$Sub_metering_1 <- as.numeric(as.character(thedata$Sub_metering_1))
thedata$Sub_metering_2 <- as.numeric(as.character(thedata$Sub_metering_2))
thedata$Sub_metering_3 <- as.numeric(as.character(thedata$Sub_metering_3))

# Creat another column "DateTime", check the class of "DateTime", and adjust the class
thedata$DateTime <- paste(thedata$Date, thedata$Time)
class(thedata$DateTime)
thedata$DateTime <- as.POSIXlt(thedata$DateTime)

#Make the plot 3:
png(filename = "plot3.png", width = 480, height = 480)
plot(thedata$DateTime, thedata$Sub_metering_1, type = "l", xlab = "", ylab = "Energe sub metering")
lines(thedata$DateTime, thedata$Sub_metering_2, type = "l", col = "red")
lines(thedata$DateTime, thedata$Sub_metering_3, type = "l", col = "blue")
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black","blue","red")) 
dev.off()


