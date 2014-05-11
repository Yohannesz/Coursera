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

##creat a new time variable including Date and Time
powersub$time<-as.POSIXct(paste(powersub$Date, powersub$Time))



## Plot 3


plot(powersub$Sub_metering_1~powersub$time,ann=FALSE, type="n")
lines(powersub$Sub_metering_1~powersub$time, lwd=1)
lines(powersub$Sub_metering_3~powersub$time, lwd=1, col="blue")
lines(powersub$Sub_metering_2~powersub$time, lwd=2, col="red")
legend("topright", pch=1, col=c("black", "blue", "red"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", width = 480, height = 480)
dev.off()