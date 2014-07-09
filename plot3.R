library(lubridate)
draw_plot3 <- function(){
  data <- read.delim('household_power_consumption.txt', sep=";", header=TRUE, as.is=TRUE)
  data <- transform(data, Date=as.Date(data$Date, format="%d/%m/%Y"))
  feb2007Data <- data[year(data$Date) == 2007 & month(data$Date) == 2 & (day(data$Date) == 1 | day(data$Date) == 2) , ]
  feb2007Data <- transform(feb2007Data, Sub_metering_1 = as.numeric(Sub_metering_1), Sub_metering_2 = as.numeric(Sub_metering_2), Sub_metering_3 = as.numeric(Sub_metering_3))
  feb2007Data <- transform(feb2007Data, DateTime = as.POSIXct(paste(feb2007Data$Date, feb2007Data$Time), format="%Y-%m-%d %H:%M:%S"))
  feb2007Data <- na.omit(feb2007Data)
  png("plot3.png", width=480, height=480, units="px")
  plot(feb2007Data$DateTime, feb2007Data$Sub_metering_1, type="n", main="", ylab="Energy sub metering", xlab="")
  lines(feb2007Data$DateTime, feb2007Data$Sub_metering_1, type="l")
  lines(feb2007Data$DateTime, feb2007Data$Sub_metering_2, type="l" , col="red")
  lines(feb2007Data$DateTime, feb2007Data$Sub_metering_3, type="l" , col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
  dev.off()
}
