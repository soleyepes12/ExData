# Peer-graded Assignment: Course Project 1 #

# 1. read and organize data
data <- read.table("household_power_consumption.txt", skip = 1, sep =";")
names(data) <- c("Date","Time","Global_active_power","Global_reactive_power",
                 "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
head (data)

# 2. Subset data
data_2 <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")
head(data_2)

# 3. First plot
hist(as.numeric(data$Global_active_power), col = "purple", main = "Global Active Power", 
     ylab = "Frequency", xlab = "Global Active Power(kilowatts)")

#4.Transformation date and time
data_2$Date <- as.Date(data_2$Date, format="%d/%m/%Y")
data_2$Time <- strptime(data_2$Time, format="%H:%M:%S")
data_2[1:1440,"Time"] <- format(data_2[1:1440,"Time"],"2007-02-01 %H:%M:%S")
data_2[1441:2880,"Time"] <- format(data_2[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# 4. second plot
plot(data_2$Time, as.numeric(data_2$Global_active_power),
     type="l", main = "Global Active Power Vs Time", xlab="",ylab="Global Active Power (kilowatts)") 

# 5. Third plot
plot(data_2$Time, data_2$Sub_metering_1, type = "n", 
     main="Energy sub-metering", xlab = "", ylab = "Energy sub metering")

with(data_2,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(data_2,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(data_2,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))

legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# 6.Fourth plot

par(mfrow=c(2,2))

with(data_2,{
  plot(data_2$Time, as.numeric(data_2$Global_active_power), type = "l", xlab = "", ylab = "Global Active Power")  
  plot(data_2$Time, as.numeric(data_2$Voltage), type = "l", xlab = "datetime", ylab = "Voltage")
  plot(data_2$Time, data_2$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
  with(data_2, lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(data_2, lines(Time,as.numeric(as.character(Sub_metering_2)), col = "red"))
  with(data_2, lines(Time,as.numeric(as.character(Sub_metering_3)), col = "blue"))
  legend("topright", lty = 1, 
         col = c("black","red","blue"),
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         cex = 0.6)
  plot(data_2$Time, as.numeric(as.character(data_2$Global_reactive_power)),
       type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})