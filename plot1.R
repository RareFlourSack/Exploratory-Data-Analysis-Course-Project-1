## downloading and unzipping

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest_file <- "./power.zip"

download.file(url, destfile = dest_file, mode = "wb")

unzip("power.zip", exdir = "extracted_data")

## reading file and converting values

power <- read.table("./extracted_data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power$Time <- strptime(power$Time, format = "%H:%M:%S")
power[,3:9] <- lapply(power[,3:9], as.numeric)

## subsetting

subset_power <- subset(power, Date %in% as.Date(c("2007-02-01", "2007-02-02"), format = "%Y-%m-%d"))

## plotting

with(subset_power, hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red"))

## copying graphics

dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()