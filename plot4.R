#Script for the Coursera Exploratory Data Analysis Week 1 Project Assignment
#Creating Plot #4

#Step 1. Read in dataset, necessary packages to clean the data

setwd("C:/Users/green2/OneDrive - City of Boulder/data_analytics/data_tools/R_Training/coursera_datascience_specialty/course4_exploratory_data_analysis")
library(dplyr)
library(lubridate)
power <- read.table("household_power_consumption.txt", sep = ";",
                    header = F ,skip = 65000 ,nrows=10000,
                    col.names = c("Date","Time","Global_active_power",
                                  "Global_reactive_power","Voltage",
                                  "Global_intensity","Sub_metering_1",
                                  "Sub_metering_2","Sub_metering_3"))

#Step #2. Filter data for relative dates - change date / time formatting appropriately
dates<-c("1/2/2007","2/2/2007")
power<-filter(power, Date %in% dates)
power$datetime<- dmy_hms(paste(power$Date, power$Time))
power$Date<-dmy(power$Date)
power$Time<-hms(power$Time)

#Step 3. Create necessary plot
#Plot #4: 
par(mfrow = c(2,2))
with(power, {
    #subplot #1
    plot(datetime, Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = "")
    lines(datetime, Global_active_power, type = "l")
    
    #subplot #2
    plot(datetime, Voltage, type="n")
    lines(datetime, Voltage)
    
    #subplot #3
    plot(datetime, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
    lines(datetime, Sub_metering_1, type = "l")
    lines(datetime, Sub_metering_2, type = "l", col = "red")
    lines(datetime, Sub_metering_3, type = "l", col = "blue")
    legend("topright", col=c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, pch=NA, bty = "n")
    
    #subplot #4
    plot(datetime, Global_reactive_power, type="n")
    lines(datetime, Global_reactive_power)
})
dev.copy(png, file = "plot4.png")
dev.off()