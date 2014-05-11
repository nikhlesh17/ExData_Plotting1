#######Reading in the data
t2 <- read.table('household_power_consumption.txt',sep = ";",header = TRUE,
                 as.is = c('Date','Time','Global_active_power','Global_reactive_power','Voltage','Global_intensity',
                           'Sub_metering_1','Sub_metering_2','Sub_metering_3'))

#######Subsetting the data to keep only the required values
t3 <- sqldf('select Date,Time,Sub_metering_1,Sub_metering_2,Sub_metering_3 from t2 where Date in ("2/2/2007","1/2/2007")')

#######Creating the datetime values for the graph
t3$dt <- paste(t3$Date,t3$Time)
t3$dt2 <- as.POSIXct(strptime(t3$dt, "%d/%m/%Y %H:%M:%S"))


#######Creating the final graph output in png format
png(filename = "plot3.png",width = 480, height = 480,units="px") 
plot(t3$dt2,t3$Sub_metering_1,type = "l",col = 'black',ylab = "Energy sub metering",xlab = '')
lines(t3$dt2,t3$Sub_metering_2,col = 'red')
lines(t3$dt2,t3$Sub_metering_3,col = 'blue')
legend("topright",lty = 1,pch = NA,col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()

