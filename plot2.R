## Initial data read
ds <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## Format date
ds$Date <- as.Date(ds$Date, format="%d/%m/%Y")

## Get subset of data for 2/1/07-2/2/07
sub <- subset(ds, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Get rid of full dataset since we don't need it anymore
rm(ds)

## Convert date and time variables
datetime <- paste(as.Date(sub$Date), sub$Time)
sub$Datetime <- as.POSIXct(datetime)

## Create Plot 2
plot(sub$Global_active_power~sub$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Save plot2 as 480x480 png
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()