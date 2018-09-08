dataFile <- "./household_power_consumption.txt"

# Read the file as table
householdPowerDT <- read.table(
    dataFile, 
    header=TRUE, 
    sep=";", 
    na.strings = "?",
    stringsAsFactors=FALSE)

# New Column for DateTime. Merge the Date & Time columns
householdPowerDT$DateTime = with(householdPowerDT, as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

# Filter only what we need
filteredData <- subset(householdPowerDT, 
                       DateTime >= "2007-02-01" 
                       & DateTime <= "2007-02-03" )

# Format the column as numberic
filteredData$Global_active_power <- as.numeric(filteredData$Global_active_power)
filteredData$Sub_metering_1 <- as.numeric(filteredData$Sub_metering_1)
filteredData$Sub_metering_2 <- as.numeric(filteredData$Sub_metering_2)
filteredData$Sub_metering_3 <- as.numeric(filteredData$Sub_metering_3)
filteredData$Voltage <- as.numeric(filteredData$Voltage)

# Create two rows & two columns to plot base charts
par(mfrow=c(2,2))

# Plot different base chart and add annotations on top of it

dev.new(width=480, height=480)

#Chart 1
plot(x = filteredData$DateTime, 
     y = filteredData$Global_active_power,
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

#Char 2

plot(x = filteredData$DateTime, 
     y = filteredData$Voltage,
     type="l", 
     xlab="datetime", 
     ylab="Voltage")

#Chart 3
plot(x=filteredData$DateTime, y=filteredData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(filteredData$DateTime, filteredData$Sub_metering_2, col="red")
lines(filteredData$DateTime, filteredData$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

#Chart 4
plot(x = filteredData$DateTime, 
     y = filteredData$Global_reactive_power,
     type="l", 
     xlab="datetime", 
     ylab="Global_reactive_power")



dev.copy(png, "plot4.png")
dev.off()

