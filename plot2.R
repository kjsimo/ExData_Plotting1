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

with(subPowerData, plot(dateTime, Global_active_power, type = "l", 
                        xlab = NA, ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png")
dev.off()