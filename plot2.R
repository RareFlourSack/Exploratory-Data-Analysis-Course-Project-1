## reading file and converting values

power <- read.table("./extracted_data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power[,3:9] <- lapply(power[,3:9], as.numeric)

## subsetting

subset_power <- subset(power, Date %in% as.Date(c("2007-02-01", "2007-02-02"), format = "%Y-%m-%d"))
subset_power$DateTime <- as.POSIXct(paste(subset_power$Date, subset_power$Time))

Sys.setlocale("LC_TIME", "English")

## plotting

with(subset_power, plot(Global_active_power ~ DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n"))
at_ticks <- seq(min(subset_power$DateTime), max(subset_power$DateTime + (24 * 60 * 60)), by = "day")
labels <- weekdays(at_ticks, abbreviate = TRUE)
axis(1, at = at_ticks, labels = labels)

## copying graphics

dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()