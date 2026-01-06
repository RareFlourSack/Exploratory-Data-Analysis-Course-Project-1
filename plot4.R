## reading file and converting values

power <- read.table("./extracted_data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

power[,3:9] <- lapply(power[,3:9], as.numeric)

## subsetting

subset_power <- subset(power, Date %in% as.Date(c("2007-02-01", "2007-02-02"), format = "%Y-%m-%d"))
subset_power$DateTime <- as.POSIXct(paste(subset_power$Date, subset_power$Time))
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
Sys.setlocale("LC_TIME", "English")

## first plot

with(subset_power, plot(Global_active_power ~ DateTime, type = "l", ylab = "Global Active Power", xlab = "", xaxt = "n"))
at_ticks <- seq(min(subset_power$DateTime), max(subset_power$DateTime + (24 * 60 * 60)), by = "day")
labels <- weekdays(at_ticks, abbreviate = TRUE)
axis(1, at = at_ticks, labels = labels)

## second plot

with(subset_power, plot(Voltage ~ DateTime, type = "l", xlab = "datetime", ylab = "Voltage", xaxt = "n"))
axis(1, at = at_ticks, labels = labels)

## third plot

with(subset_power, plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n"))
with(subset_power, lines(Sub_metering_2 ~ DateTime, col = "red"))
with(subset_power, lines(Sub_metering_3 ~ DateTime, col = "blue"))
axis(1, at = at_ticks, labels = labels)

legend("topright", col = c("black", "red", "blue"), bty = "n", lty = 1, lwd = 2, legend =c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## fourth plot

with(subset_power, plot(Global_reactive_power ~ DateTime, type = "l", xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n"))
axis(1, at = at_ticks, labels = labels)

## copying graphics

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()