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

## Create Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(sub, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage (volt)", xlab="datetime")
    plot(Sub_metering_1~Datetime, type="l", 
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global_reactive_power",xlab="datetime")
})

## Save Plot 4 to 480x480 png
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
