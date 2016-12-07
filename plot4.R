## downloading the file
if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./data/Dataset.zip")){
	download.file(fileUrl,destfile="./data/Dataset.zip")
}

## unzipping the file
if (!file.exists("./data/household_power_consumption.txt")){
	unzip(zipfile="./data/Dataset.zip",exdir="./data")
}

## viewing the files in the folder
files<-list.files("./data", recursive=TRUE)

##Calculating the space requirement
spaceReqMB<-(2075259*9*8)/2^20

##reading the data
hpc <- read.table("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?")
hpcReqData <- hpc[hpc$Date %in% c("1/2/2007","2/2/2007") ,]

##plot4
dateTime <- strptime(paste(hpcReqData$Date, hpcReqData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(hpcReqData$Global_active_power)
globalReactivePower <- as.numeric(hpcReqData$Global_reactive_power)
voltage <- as.numeric(hpcReqData$Voltage)
subMetering1 <- as.numeric(hpcReqData$Sub_metering_1)
subMetering2 <- as.numeric(hpcReqData$Sub_metering_2)
subMetering3 <- as.numeric(hpcReqData$Sub_metering_3)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(dateTime, globalActivePower, type="l", xlab="", ylab="Global Active Power")

plot(dateTime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(dateTime, subMetering1, type="l", ylab="Energy Sub metering", xlab="")
lines(dateTime, subMetering2, type="l", col="red")
lines(dateTime, subMetering3, type="l", col="blue")
legend("topright", lty=, lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(dateTime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()