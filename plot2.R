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

plot(tbsub$DateTime,as.numeric(as.character(tbsub$Global_active_power)),type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.copy(png,"plot2.png")
dev.off()
