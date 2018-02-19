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

#plot one at a time
with(tbsub,plot(DateTime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"),yaxt="n")
lines(tbsub$DateTime,tbsub$Sub_metering_1)
lines(tbsub$DateTime,tbsub$Sub_metering_2,col="red")
lines(tbsub$DateTime,tbsub$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty="solid")
dev.copy(png,"plot3.png")
dev.off()
