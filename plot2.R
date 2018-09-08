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

# Plot the Chart
dev.new(width=480, height=480)
plot(x = filteredData$DateTime, 
     y = filteredData$Global_active_power,
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

dev.copy(png, "plot2.png")
dev.off()

