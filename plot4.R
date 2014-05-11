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





par(mfrow = c(2, 2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(powersub, {
   plot (time, Global_active_power/1000 , type="n")
        lines(Global_active_power/1000~time, lwd=1)
   plot (time, Voltage, type="n", xlab="datetime")
        lines(Voltage~time, lwd=1)
   plot (Sub_metering_1~time,ann=FALSE, type="n")
         lines(Sub_metering_1~time, lwd=1)
         lines(Sub_metering_3~time, lwd=1, col="blue")
         lines(Sub_metering_2~time, lwd=2, col="red")
   plot (time, Global_reactive_power, type="n", xlab="datetime")
        lines(Global_reactive_power~time, lwd=1)
 })

dev.copy(png, file="plot4.png", width = 480, height = 480)
dev.off()

