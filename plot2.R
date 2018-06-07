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

# plot Global Active Power as a function of date and time
## first convert Date and Time variables
datetime <- strptime(paste(subpowerdata$Date, subpowerdata$Time), "%d/%m/%Y %H:%M:%S")

## subset the globalactivepowerdata
globalactivepower <- subpowerdata$Global_active_power

plot(datetime, globalactivepower, type = "l", xlab = "", ylab = "Global Active Power (kilowatts")

dev.copy(png, "plot2.png")
dev.off()