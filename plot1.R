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
spaceReq<-(2075259*9*8)/2^20

##reading the data
hpc <- read.table("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?")
hpcReqData <- hpc[hpc$Date %in% c("1/2/2007","2/2/2007") ,]

##plot1
globalActivePower <- as.numeric(hpcReqData$Global_active_power)
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()