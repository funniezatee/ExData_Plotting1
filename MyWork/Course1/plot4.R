## set path
setwd("~/Desktop/Data Science/4.Exploratory data")

## read data
data <- read.table("household_power_consumption.txt", sep=";", 
                   header=TRUE, stringsAsFactors=FALSE, 
                   colClasses=c( "character", "character", rep("numeric",7)) ,na.strings='?')

## format data
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data2day <- subset(data, data$Date>=as.Date("2007-02-01") & data$Date<=as.Date("2007-02-02"))
data2day$datetime <- as.POSIXct(paste(data2day$Date,data2day$Time), format="%Y-%m-%d %H:%M:%S")


## plot 2x2:

# setup
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
par(mfrow=c(2,2))

# plot1
plot(data2day$datetime, data2day$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# plot2
plot(data2day$datetime, data2day$Voltage, type="l", xlab="datetime", ylab="Voltage")

# plot3
plot(data2day$datetime, data2day$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data2day$datetime, data2day$Sub_metering_2, type="l", xlab="", ylab="Energy sub metering", col="red")
lines(data2day$datetime, data2day$Sub_metering_3, type="l", xlab="", ylab="Energy sub metering", col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col= c("black","red","blue"), lty=c(1,1,1), bty = "n")

# plot4
plot(data2day$datetime, data2day$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")


# closeup
dev.off()


