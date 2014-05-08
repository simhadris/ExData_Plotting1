master <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE)
func <- function(x,y) {paste(x,y, sep = " ")}
master$Date1<- mapply(func, master$Date, master$Time)
master$Date <- strptime(master$Date1, format = "%d/%m/%Y %H:%M:%S")
data <- subset(master, master$Date >= as.POSIXlt("2007-02-01") & master$Date < as.POSIXlt("2007-02-03"))
data$Global_active_power <- as.numeric(data$Global_active_power, na.rm = TRUE)
png(file = "plot2.png", width = 480, height = 480)
plot(data$Date, data$Global_active_power, type = "l",xlab = "" ,ylab="Global Active Power (kilowatts)")
dev.off()