library(dplyr)

## read data
data_table <- read.table('household_power_consumption.txt', sep = ";", header = TRUE, na.strings = "?", colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'))
data_table$Date <- as.Date(data_table$Date, "%d/%m/%Y")

## get the data for the right date
data_table <- subset(data_table, Date >= as.Date("1/2/2007", "%d/%m/%Y") & Date <=  as.Date("2/2/2007", "%d/%m/%Y"))
data_table <- data_table[complete.cases(data_table),]

## merge date and time columns
DateTime <- paste(data_table$Date, data_table$Time)

## create a new datetime column
test_table <- mutate(select(data_table, c(-Date,-Time)) , DateTime = as.POSIXct(DateTime))

#plot3
par(mfrow=c(1,1))
with(test_table, plot(Sub_metering_1~DateTime, type="l", ylab="Energy sub metering", xlab="", col="black"))
lines(test_table$Sub_metering_2~test_table$DateTime,col='Red')
lines(test_table$Sub_metering_3~test_table$DateTime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
