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
names(houseHoldData)<-names(namesHeader)

with(houseHoldData,
     hist(Global_active_power,col="red",
          xlab="Global Active Power (Kilowatts)"))

dev.copy(png,file="plot1.png")
