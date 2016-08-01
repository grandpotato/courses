#This script produces a plot of the Power consumption of the submetering from the UC Irvine Machine Learning Repository
hpc <- read.table(file = "household_power_consumption.txt",header=TRUE,sep= ";",colClasses = c("character","character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")
hpc <- cbind(DateTime = as.POSIXct(paste(hpc$Date,hpc$Time),format="%d/%m/%Y %H:%M:%S", "GMT"),hpc)
febdata <- subset(hpc, as.Date(DateTime) == as.Date("2007-02-01",tz = "GMT")|as.Date(DateTime) == as.Date("2007-02-02",tz = "GMT"))

png(filename = "plot3.png", width = 480,height = 480,units="px")
plot(febdata$DateTime,febdata$Sub_metering_1, type = "l",xlab="",ylab="Global Active Power (kilowatts)")
points(febdata$DateTime,febdata$Sub_metering_2, type = "l",col="red")
points(febdata$DateTime,febdata$Sub_metering_3, type = "l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1),col = c("black", "red", "blue"))
dev.off()
