setwd("~/Desktop/Data Science/4.Exploratory data/Course2/exdata_data_NEI_data")

NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)


## Question 1
plot1 <- ddply(NEI, .(year), summarize, total_E=sum(Emissions))

#str(plot1)
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
plot(plot1$year, plot1$total_E, main="PM2.5 emissions in US", xlab="year", ylab="Emissions")
dev.off()

## Question 2
plot2 <- subset(NEI, NEI$fips == "24510")
plot2 <- ddply(plot2, .(year), summarize, total_E=sum(Emissions))
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
plot(plot2$year, plot2$total_E, main="PM2.5 emissions in Baltimore City", xlab="year", ylab="Emissions")
dev.off()

## Question 3
library(ggplot2)
plot3 <- subset(NEI, NEI$fips == "24510")
plot3 <- ddply(plot3, .(year, type), summarize, total_E=sum(Emissions))
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
ggplot(plot3, aes(x=year, y=total_E, color=type))+geom_line()+
  ggtitle("PM2.5 emissions in Baltimore City")
dev.off()

## Question 4
coalrelated <- SCC[grep("coal", SCC$Short.Name, ignore.case=TRUE), ]
coalrelated.data <- subset(NEI, NEI$SCC %in% coalrelated$SCC)
plot4 <- ddply(coalrelated.data, .(year), summarize, total_E=sum(Emissions))
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
ggplot(plot4, aes(x=year, y=total_E))+geom_line()+
  ggtitle("PM2.5 Coal combustion-related emissions across US")
dev.off()

## Question 5
plot5 <- subset(NEI, NEI$fips == "24510")
motor.related <- SCC[grep("motor", SCC$Short.Name, ignore.case=TRUE), ]
motor.related.data <- subset(plot5, motor.related$SCC %in% plot5$SCC)
plot5.final <- ddply(motor.related.data, .(year), summarize, total_E=sum(Emissions))

png(filename = "plot5.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
ggplot(plot5.final, aes(x=year, y=total_E))+geom_line()+
  ggtitle("PM2.5 Motor vehicle emissions in Baltimore City")
dev.off()
  
## Question 6
plot6 <- subset(NEI, NEI$fips == "06037")
motor.related <- SCC[grep("motor", SCC$Short.Name, ignore.case=TRUE), ]
plot6.motor.related.data <- subset(plot6, motor.related$SCC %in% plot6$SCC)
plot6.final <- ddply(plot6.motor.related.data, .(year), summarize, total_E=sum(Emissions))

png(filename = "plot6.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
baltimore <- ggplot(plot5.final, aes(x=year, y=total_E))+geom_line()+
  ggtitle("PM2.5 Motor vehicle emissions in Baltimore City")
losA <- ggplot(plot6.final, aes(x=year, y=total_E))+geom_line()+
  ggtitle("PM2.5 Motor vehicle emissions in Los Angeles")
library(gridExtra)
grid.arrange(baltimore, losA)
dev.off()

# check the greater range
baltimore.range <- max(plot5.final$total_E)-min(plot5.final$total_E)
losA.range <- max(plot6.final$total_E)-min(plot6.final$total_E)

