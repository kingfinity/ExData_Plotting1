setwd("./M4W1")
getwd()

tb<-read.table(file="household_power_consumption.txt",sep=";",header=TRUE)
class(tb)

#Convert to Date
tb$Date<-as.Date(tb$Date,"%d/%m/%Y")
head(tb)

#Work only on data from 2007-02-01 and 2007-02-02
tbsub<-tb[tb$Date=="2007-02-01"|tb$Date=="2007-02-02",]
head(tbsub)

class(tbsub$Global_active_power)
#[1] "factor"

#Convert Factor to Numeric
tbsub$Global_active_power<-as.numeric(as.character(tbsub$Global_active_power))
hist(tbsub$Global_active_power,xlab="Global Active Power (kilowatts)",main="Global Active Power",col="red")
dev.copy(png,"plot1.png")
dev.off()
