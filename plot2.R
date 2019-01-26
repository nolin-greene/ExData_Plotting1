#Script for the Coursera Exploratory Data Analysis Week 1 Project Assignment
#Creating Plot #2

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
#Plot #2: 
with(power, plot(datetime, Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = ""))
with(power, lines(datetime, Global_active_power), type = "l")
dev.copy(png, file = "plot2.png")
dev.off()