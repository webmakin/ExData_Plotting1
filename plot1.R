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

## plot1 
par(mfrow=c(1,1))
hist(test_table$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
