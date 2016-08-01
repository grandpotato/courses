#This script produces a plot of the GlobalActive Power from the UC Irvine Machine Learning Repository
hpc <- read.table(file = "household_power_consumption.txt",header=TRUE,sep= ";",colClasses = c("character","character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")
hpc <- cbind(DateTime = as.POSIXct(paste(hpc$Date,hpc$Time),format="%d/%m/%Y %H:%M:%S", "GMT"),hpc)
febdata <- subset(hpc, as.Date(DateTime) == as.Date("2007-02-01",tz = "GMT")|as.Date(DateTime) == as.Date("2007-02-02",tz = "GMT"))

png(filename = "plot2.png", width = 480,height = 480,units="px")
plot(febdata$DateTime,febdata$Global_active_power, type = "l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
