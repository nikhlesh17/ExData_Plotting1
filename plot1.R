#######Reading in the data
t2 <- read.table('household_power_consumption.txt',sep = ";",header = TRUE,
                 as.is = c('Date','Time','Global_active_power','Global_reactive_power','Voltage','Global_intensity',
                           'Sub_metering_1','Sub_metering_2','Sub_metering_3'))

#######Subsetting the data to keep only the required values
t3 <- sqldf('select Global_active_power from t2 where Date in ("2/2/2007","1/2/2007")')

#######Setting the value as numeric for histogram
t3$Global_active_power <- as.numeric(t3$Global_active_power)

#######Creating the final plot in png format
png(filename = "plot1.png",width = 480, height = 480,units="px") 
hist(t3$Global_active_power,ylim = c(0,1200),xlab = "Global Active Power(Kilowatts)"
     ,main = "Global Active Power",col = "red")
dev.off()

