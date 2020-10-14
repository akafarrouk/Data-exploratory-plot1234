library(dplyr)
library(lubridate)

#reading specific data got the hard way :) by experimenting slowly
temp<-read.table("data/household_power_consumption.txt",
                 sep=";",
                 col.names = c("Date","Time","Global_active_power",
                               "Global_reactive_power","Voltage",
                               "Global_intensity","Sub_metering_1",
                               "Sub_metering_2","Sub_metering_3"),
                 nrow=2880,skip=66637,header=TRUE,
                 na.strings="?")

houseHoldData<-tibble::as_tibble(transform(temp,Date=as.Date(dmy(Date))))
houseHoldData$Date<-as.Date(houseHoldData$Date,format="%d:%m:%Y")
houseHoldData$Time<-strptime(houseHoldData$Time,format="%H:%M:%S")

with(houseHoldData,plot(Time,Sub_metering_1,type="n"))
with(houseHoldData,lines(Time,Sub_metering_1))
with(houseHoldData,lines(Time,Sub_metering_2,col="red"))
with(houseHoldData,lines(Time,Sub_metering_3,col="blue"))

legend("topright", lty=1, 
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


