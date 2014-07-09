library(lubridate)
draw_plot4 <- function(){
  data <- read.delim('household_power_consumption.txt', sep=";", header=TRUE, as.is=TRUE)
  data <- transform(data, Date=as.Date(data$Date, format="%d/%m/%Y"))
  #Filter down data
  feb2007Data <- data[year(data$Date) == 2007 & month(data$Date) == 2 & (day(data$Date) == 1 | day(data$Date) == 2) , ]
  # Preparing the data
  feb2007Data <- transform(feb2007Data, Global_active_power = as.numeric(Global_active_power))
  feb2007Data <- transform(feb2007Data, Global_reactive_power = as.numeric(Global_reactive_power))
  feb2007Data <- transform(feb2007Data, Voltage = as.numeric(Voltage))
  feb2007Data <- transform(feb2007Data, Sub_metering_1 = as.numeric(Sub_metering_1), Sub_metering_2 = as.numeric(Sub_metering_2), Sub_metering_3 = as.numeric(Sub_metering_3))
  # Create a new column with DateTime
  feb2007Data <- transform(feb2007Data, DateTime = as.POSIXct(paste(feb2007Data$Date, feb2007Data$Time), format="%Y-%m-%d %H:%M:%S"))
  feb2007Data <- na.omit(feb2007Data)  # Remove NAs

  png("plot4.png", width=480, height=480, units="px")
  par(mfrow=c(2,2)) # Two by Two plots

  # Drawing first plot
  plot(feb2007Data$DateTime, feb2007Data$Global_active_power, type="l", main="", ylab="Global Active Power (kilowatts)", xlab="")

  # Drawing second plot
  plot(feb2007Data$DateTime, feb2007Data$Voltage, type="l", main="", ylab="Voltage", xlab="datetime")

  # Drawing third plot
  plot(feb2007Data$DateTime, feb2007Data$Sub_metering_1, type="l", main="", ylab="Energy sub metering", xlab="")
  lines(feb2007Data$DateTime, feb2007Data$Sub_metering_2, type="l" , col="red")
  lines(feb2007Data$DateTime, feb2007Data$Sub_metering_3, type="l" , col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n")

  # Drawing fourth plot
  plot(feb2007Data$DateTime, feb2007Data$Global_reactive_power, type="l", main="", ylab="Global_reactive_power", xlab="datetime")
  dev.off()
}
