## reading file and converting values

power <- read.table("./extracted_data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

## subsetting


subset_power <- subset(power, Date %in% as.Date(c("2007-02-01", "2007-02-02"), format = "%Y-%m-%d"))
subset_power$DateTime <- as.POSIXct(paste(subset_power$Date, subset_power$Time))

## plotting

with(subset_power, plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n"))
with(subset_power, lines(Sub_metering_2 ~ DateTime, col = "red"))
with(subset_power, lines(Sub_metering_3 ~ DateTime, col = "blue"))

## setting up x-axis labels

at_ticks <- seq(min(subset_power$DateTime), max(subset_power$DateTime + (24 * 60 * 60)), by = "day")
labels <- weekdays(at_ticks, abbreviate = TRUE)
axis(1, at = at_ticks, labels = labels)

## setting up legend

legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, legend =c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## copying graphics 

dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()