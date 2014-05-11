#Read Data set#
power = read.table("./Desktop/coursera/household_power_consumption.txt", 
                   sep=";", 
                   col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
                   fill=FALSE, 
                   strip.white=TRUE, skip=1)

#change the Date format#
power[,1]=as.Date(power[,1], format= "%d/%m/%Y")

##subset the required data

powersub<-subset(power, as.Date(Date) >= '2007-02-01' & as.Date(Date) <= '2007-02-02') 

## check vector type

sapply(powersub, class)

##change vector type

powersub<-transform(powersub, Global_active_power = as.numeric(Global_active_power),
                    Global_reactive_power = as.numeric(Global_reactive_power),
                    Voltage = as.numeric(Voltage), 
                    Global_intensity = as.numeric(Global_intensity),
                    Sub_metering_1=as.numeric(Sub_metering_1), 
                    Sub_metering_2=as.numeric(Sub_metering_2),
                    Sub_metering_3=as.numeric(Sub_metering_3)
)

##construct histogram Plot 1


hist(powersub$Global_active_power, col="red", xlab="Global Active Power (Kilowatts)", 
     ylab= "Frequency", main="Global Active Power")
dev.copy(png, file="plot1.png", width = 480, height = 480)
dev.off()
