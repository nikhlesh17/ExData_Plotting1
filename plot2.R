#######Reading in the data
t2 <- read.table('household_power_consumption.txt',sep = ";",header = TRUE,
                as.is = c('Date','Time','Global_active_power','Global_reactive_power','Voltage','Global_intensity',
                          'Sub_metering_1','Sub_metering_2','Sub_metering_3'))

#######Subsetting the data to keep only the required values
t3 <- sqldf('select Date,Time,Global_active_power from t2 where Date in ("2/2/2007","1/2/2007")')

#######Setting the value as numeric
t3$Global_active_power <- as.numeric(t3$Global_active_power)

#######Creating the datetime values for the graph
t3$dt <- paste(t3$Date,t3$Time)
t3$dt2 <- as.POSIXct(strptime(t3$dt, "%d/%m/%Y %H:%M:%S"))

#######Creating the final graph output in png format
png(filename = "plot2.png",width = 480, height = 480,units="px") 
plot(t3$dt2,t3$Global_active_power,type = "l",xlab = '',ylab = "Global Active Power(Kilowatts)")
dev.off()


