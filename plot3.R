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
filteredData$Sub_metering_1 <- as.numeric(filteredData$Sub_metering_1)
filteredData$Sub_metering_2 <- as.numeric(filteredData$Sub_metering_2)
filteredData$Sub_metering_3 <- as.numeric(filteredData$Sub_metering_3)

# Plot the base chart and add annotations on top of it

dev.new(width=480, height=480)

plot(x=filteredData$DateTime, y=filteredData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(filteredData$DateTime, filteredData$Sub_metering_2, col="red")
lines(filteredData$DateTime, filteredData$Sub_metering_3, col="blue")

legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))


dev.copy(png, "plot3.png")
dev.off()

