library(tools)
library(data.table)
library(gsubfn)
library(dplyr)
library(Hmisc)
library(lubridate)

powerData <- fread("household_power_consumption.txt", na.strings=c("NA","N/A","", "?"))
selectData <- subset(powerData, Date == "1/2/2007" | Date == "2/2/2007" )
subPowerData <- mutate(selectData, Date = as.Date(Date, "%d/%m/%Y"))
x <- subPowerData$Date
y <- subPowerData$Time
dateTime <- paste(x,y)
dateTime <- strptime(dateTime, "%Y-%m-%d %H:%M:%S")
subPowerData <- cbind(dateTime, subPowerData)
subPowerData <- mutate(subPowerData, Global_active_power = as.numeric(Global_active_power))
subPowerData <- mutate(subPowerData, Sub_metering_1 = as.numeric(Sub_metering_1))
subPowerData <- mutate(subPowerData, Sub_metering_2 = as.numeric(Sub_metering_2))
subPowerData <- mutate(subPowerData, Sub_metering_3 = as.numeric(Sub_metering_3))
subPowerData <- mutate(subPowerData, Voltage = as.numeric(Voltage))
subPowerData <- mutate(subPowerData, Global_reactive_power = as.numeric(Global_reactive_power))
################################################################################
## Set up Multiple Plots
################################################################################
par(mfrow = c(2, 2), mar = c(4,4,4,4), oma = c(0,0,0,0)) 

with(subPowerData, {
    
## Plot 1
plot(dateTime, Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)")
## Plot 2
plot(dateTime, Voltage, type = "l", xlab = NA, ylab = "Voltage")

## Plot 3
plot(dateTime,Sub_metering_1 , type = "l", xlab = NA, ylab = "Energy sub metering")
lines(dateTime, Sub_metering_2, col = "red")
lines(dateTime, Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot 4
plot(dateTime, Global_reactive_power, type = "l", ylab = "Global_reactive_power")

}) 
################################################################################
## End of  Multiple Plots
################################################################################


#######
## Output to PNG
#########
dev.copy(png, file = "./ExData_Plotting1/plot4.png")
dev.off()