## set path
setwd("~/Desktop/Data Science/4.Exploratory data")

## read data
data <- read.table("household_power_consumption.txt", sep=";", 
                   header=TRUE, stringsAsFactors=FALSE, 
                   colClasses=c( "character", "character", rep("numeric",7)) ,na.strings='?')

## format data
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- as.POSIXct(data$Time, format="%H:%M:%S")
data2day <- subset(data, data$Date>=as.Date("2007-02-01") & data$Date<=as.Date("2007-02-02"))

## plot 1
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
hist <- hist(data2day$Global_active_power)
plot(hist, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()



