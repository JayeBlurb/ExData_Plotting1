#this code assumes that the data file is extracted and saved in the original name in the working directory

#read only the data for Feb 1 to Feb 2, 2007 
data <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", skip = 66637, nrows = 2880)
colnames(data)<-c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#reformat the date variable and merge date and time variables
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$datetime <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

#configure the graphic device and save the file in the working directory
png(file="plot3.png", width=480, height=480)

#create the graph
with(data, plot(datetime, Sub_metering_1, type = 'n', ylab= "Energy sub metering", xlab=""))
with(data, lines(datetime, Sub_metering_1, type = 'l'))
with(data, lines(datetime, Sub_metering_2, col="red", type = 'l'))
with(data, lines(datetime, Sub_metering_3, col="blue", type = 'l'))

#add legend
legend("topright", lty=c(1, 1, 1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#close the device
dev.off()