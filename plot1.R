library(lubridate)
draw_plot1 <- function(){
  data <- read.delim('household_power_consumption.txt', sep=";", header=TRUE, as.is=TRUE)
  data <- transform(data, Date=as.Date(data$Date, format="%d/%m/%Y"))
  feb2007Data <- data[year(data$Date) == 2007 & month(data$Date) == 2 & (day(data$Date) == 1 | day(data$Date) == 2) , ]
  feb2007Data <- transform(feb2007Data, Global_active_power = as.numeric(Global_active_power))
  feb2007Data <- na.omit(feb2007Data)
  png("plot1.png", width=480, height=480, units="px")
  hist(feb2007Data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency" )
  dev.off()
}
