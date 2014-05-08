master <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE)
func <- function(x,y) {paste(x,y, sep = " ")}
master$DateTime1<- mapply(func, master$Date, master$Time)
master$DateTime <- strptime(master$DateTime1, format = "%d/%m/%Y %H:%M:%S")
master$Date <- strptime(master$Date, format = "%d/%m/%Y")
data <- subset(master, master$Date >= as.POSIXlt("2007-02-01") & master$Date < as.POSIXlt("2007-02-03"))
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1, na.rm = TRUE)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2, na.rm = TRUE)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3, na.rm = TRUE)
data$Global_active_power <- as.numeric(data$Global_active_power, na.rm = TRUE)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power, na.rm = TRUE)
data$Voltage <- as.numeric(data$Voltage, na.rm = TRUE)

png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(data, {
#plot1
plot(data$DateTime, data$Global_active_power, type = "l",xlab = "" ,ylab="Global Active Power")

#plot2
plot(data$DateTime, data$Voltage, type = "l",xlab = "datetime" ,ylab="Voltage")

#plot3
plot(data$DateTime, data$Sub_metering_1, col = "black",type = "l",xlab = "" ,ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col = "red",type = "l")
lines(data$DateTime, data$Sub_metering_3, col = "blue",type = "l")
legend("topright", col = c("black","red","blue"), bty = "n", cex = 1,lty = 1,legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

#plot4
plot(data$DateTime, data$Global_reactive_power, type = "l",xlab = "datetime" ,ylab="Global_reactive_power")
})
dev.off()