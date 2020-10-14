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

par(mfrow=c(2,2))

# calling the basic plot function that calls different plot functions to build the 4 plots that form the graph
with(houseHoldData,{
    plot(houseHoldData$Time,houseHoldData$Global_active_power,type="l",  xlab="",ylab="Global Active Power")  
    plot(houseHoldData$Time,subpower$Voltage, type="l",xlab="datetime",ylab="Voltage")
    plot(houseHoldData$Time,houseHoldData$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
    with(houseHoldData,lines(Time,Sub_metering_1))
    with(houseHoldData,lines(Time,Sub_metering_2,col="red"))
    with(houseHoldData,lines(Time,Sub_metering_3,col="blue"))
    legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
    plot(houseHoldData$Time,houseHoldData$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
})

#copying to png
dev.copy(png, filename="plot4.png")
dev.off()