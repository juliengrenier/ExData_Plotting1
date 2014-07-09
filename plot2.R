library(lubridate)
draw_plot2 <- function(){
  data <- read.delim('household_power_consumption.txt', sep=";", header=TRUE, as.is=TRUE)
  data <- transform(data, Date=as.Date(data$Date, format="%d/%m/%Y"))
  feb2007Data <- data[year(data$Date) == 2007 & month(data$Date) == 2 & (day(data$Date) == 1 | day(data$Date) == 2) , ]
  feb2007Data <- transform(feb2007Data, Global_active_power = as.numeric(Global_active_power))
  feb2007Data <- transform(feb2007Data, DateTime = as.POSIXct(paste(feb2007Data$Date, feb2007Data$Time), format="%Y-%m-%d %H:%M:%S"))
  feb2007Data <- na.omit(feb2007Data)
  png("plot2.png", width=480, height=480, units="px")
  plot(feb2007Data$DateTime, feb2007Data$Global_active_power, type="n", main="", ylab="Global Active Power (kilowatts)", xlab="")
  lines(feb2007Data$DateTime, feb2007Data$Global_active_power, type="l" )
  dev.off()
}
