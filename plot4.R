#######Reading in the data
t2 <- read.table('household_power_consumption.txt',sep = ";",header = TRUE,
                 as.is = c('Date','Time','Global_active_power','Global_reactive_power','Voltage','Global_intensity',
                           'Sub_metering_1','Sub_metering_2','Sub_metering_3'))

#######Creating the datetime values for the graph
t2$dt <- paste(t2$Date,t2$Time)
t2$dt2 <- as.POSIXct(strptime(t2$dt, "%d/%m/%Y %H:%M:%S"))

#######Subsetting the data as per required dates
t4 <- sqldf('select * from t2 where Date in ("2/2/2007","1/2/2007")')

#######Creating the final graph output in png format
png(filename = "plot4.png",width = 480, height = 480,units="px") 
par(mfrow = c(2,2))
plot(t4$dt2,t4$Global_active_power,type = "l",xlab = '',ylab = "Global Active Power")
plot(t4$dt2,t4$Voltage,type = "l",xlab = 'datetime',ylab = "Voltage")
plot(t4$dt2,t4$Sub_metering_1,type = "l",col = 'black',ylab = "Energy sub metering",xlab = '')
lines(t4$dt2,t4$Sub_metering_2,col = 'red')
lines(t4$dt2,t4$Sub_metering_3,col = 'blue')
legend("topright",lty = 1,pch = NA,col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
plot(t4$dt2,t4$Global_reactive_power,type = "l",xlab = 'datetime',ylab = "Global_reactive_power")
dev.off()
