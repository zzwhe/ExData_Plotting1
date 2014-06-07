
# Download file, unzip, read and assign the file to "datafile".
# If you can not download the file, you can get the file from the project, and save the file to your computer.

temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
datafile <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";")
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
# Change the "factor" class to "numeric"
thedata$Global_active_power <- as.numeric(as.character(thedata$Global_active_power))

#Make the plot 1:
png(filename = "plot1.png", width = 480, height = 480)
par(mfrow = c(1,1), mar = c(4,4,2,2))
hist(thedata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
