
dataFile <- "./Week1/household_power_consumption.txt"

# Read the file as table
householdPowerDT <- read.table(
    dataFile, 
    header=TRUE, 
    sep=";", 
    na.strings = "?",
    stringsAsFactors=FALSE)

# Format the Date column
householdPowerDT$Date = as.Date(householdPowerDT$Date, "%d/%m/%Y")

# Filter only what we need
filteredData <- subset(householdPowerDT, 
                       Date == as.Date("01/02/2007", "%d/%m/%Y") 
                        | Date == as.Date("02/02/2007", "%d/%m/%Y"))

# Format the column as numberic
filteredData$Global_active_power <- as.numeric(filteredData$Global_active_power)

# Plot the Chart
hist(filteredData$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.copy(png, "plot1.png")
dev.off()
