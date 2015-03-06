## set path
setwd("~/Desktop/Data Science/4.Exploratory data")

## read data
data <- read.table("household_power_consumption.txt", sep=";", 
                   header=TRUE, stringsAsFactors=FALSE, 
                   colClasses=c( "character", "character", rep("numeric",7)) ,na.strings='?')

## format data
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data2day <- subset(data, data$Date>=as.Date("2007-02-01") & data$Date<=as.Date("2007-02-02"))


## plot 2
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
data2day$datetime <- as.POSIXct(paste(data2day$Date,data2day$Time), format="%Y-%m-%d %H:%M:%S")
plot(data2day$datetime, data2day$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()