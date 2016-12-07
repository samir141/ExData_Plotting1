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

##plot3
dateTime <- strptime(paste(hpcReqData$Date, hpcReqData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(hpcReqData$Global_active_power)
subMetering1 <- as.numeric(hpcReqData$Sub_metering_1)
subMetering2 <- as.numeric(hpcReqData$Sub_metering_2)
subMetering3 <- as.numeric(hpcReqData$Sub_metering_3)

png("plot3.png", width=480, height=480)
plot(dateTime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(dateTime, subMetering2, type="l", col="red")
lines(dateTime, subMetering3, type="l", col="blue")
legend("topright", lty=1, lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
dev.off()