setwd("./M4W1")
getwd()

tb<-read.table(file="household_power_consumption.txt",sep=";",header=TRUE)
class(tb)

#Convert to Date
tb$Date<-as.Date(tb$Date,"%d/%m/%Y")
head(tb)

#Work only on data from 2007-02-01 and 2007-02-02,merge date and time to one col
tbsub<-tb[tb$Date=="2007-02-01"|tb$Date=="2007-02-02",]

#add one column for combined Date and Time field
library(dplyr)
tbsub<-mutate(tbsub,DateTime=as.POSIXct(paste(tbsub$Date, tbsub$Time), format="%Y-%m-%d %H:%M:%S"))
head(tbsub)

#set 2x2 plotting area
par(mfrow=c(2,2))

#1
with(tbsub,plot(DateTime,as.numeric(as.character(Global_active_power)),type="l",ylab="Global Active Power",xlab=""))

#2
with(tbsub,plot(DateTime,as.numeric(as.character(Voltage)),type="l",xlab="datetime",ylab="Voltage"))

#3
with(tbsub,plot(DateTime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"),yaxt="n")
lines(tbsub$DateTime,tbsub$Sub_metering_1)
lines(tbsub$DateTime,tbsub$Sub_metering_2,col="red")
lines(tbsub$DateTime,tbsub$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty="solid",bty="n",y.intersp=0.3)

#4
with(tbsub,plot(DateTime,as.numeric(as.character(Global_reactive_power)),type="l",ylab="Global_reactive_power",xlab="datetime"))

dev.copy(png,"plot4.png")
dev.off()
