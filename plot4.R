# download file from url
fileurl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(fileurl, destfile = "./powerconsumption.zip", method = "curl")

# unzip file
unzip(zipfile = "./powerconsumption.zip")

# unzipped file is a file called household_power_consumption.txt

# read data; missing vales are denoted as '?' not 'NA'
powerdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# check data
head(powerdata)

# subset 2007-02-01 and 2007-02-02 data. Date in table is in format dd/mm/yyyy
subpowerdata <- subset(powerdata, powerdata$Date == "1/2/2007" | powerdata$Date == "2/2/2007")

# check data
head(subpowerdata)
tail(subpowerdata)
dim(subpowerdata)

## first convert Date and Time variables
datetime <- strptime(paste(subpowerdata$Date, subpowerdata$Time), "%d/%m/%Y %H:%M:%S")

# plot 4 graphs on the same graphic
par(mfrow = c(2,2), mar = c(4,4,2,1))

        ## subset the globalactivepowerdata
        globalactivepower <- subpowerdata$Global_active_power
        ## subset the globalactivepowerdata
        volt <- subpowerdata$Voltage
        
        ## subset the sub metering
        submeter1 <- subpowerdata$Sub_metering_1
        submeter2 <- subpowerdata$Sub_metering_2
        submeter3 <- subpowerdata$Sub_metering_3
        
        ## subset globalreactive power
        globalReactivepower <- subpowerdata$Global_reactive_power
        
# Plot 1
        plot(datetime, globalactivepower, type = "l", xlab = "", ylab = "Global Active Power")

# Plot 2
        plot(datetime, volt, type = "l", xlab = "", ylab = "Voltage")
        
# Plot 3
        plot(datetime, submeter1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
        
        lines(datetime, submeter2, col = "red")
        
        lines(datetime, submeter3, col = "blue")
        
        legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, cex = 0.4)
        
# Plot 4
        plot(datetime, globalReactivepower, type = "l", xlab = "", ylab = "Global_eactive_power")

dev.copy(png, "plot4.png")
dev.off()