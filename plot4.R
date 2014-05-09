#This R script creates 4 plots in 1

#This routine will be used throughout all the plotting scripts
#dt is a vector, containing 2 dates in a date format, that we are interested in
dt <- c(as.Date('01/02/2007', format = '%d/%m/%Y'), as.Date('02/02/2007', format = '%d/%m/%Y'))
#reading data from file, using ';' as a separator, counting all columns as character at first 
#and introducing NAs instead of '?'
data <- read.table("household_power_consumption.txt", sep = ';', header = TRUE, colClasses = "character", na.strings = '?')
#formatting Date column to data, using specified format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
#subsetting our data to just two specific dates
data <- subset(data, Date==dt[1] | Date==dt[2])
#creating a vector, containing full date + time character line
full_date <- paste(data$Date, data$Time, sep = ':')
#formatting our date+time vector to POSIXlt and POSIXt
full_date <- strptime(full_date, format = '%Y-%m-%d:%H:%M:%S')
#After that we have all the data we need and we can continue with the plot itself

#initializing png graphic device
png('plot4.png')
#setting params for 2 v 2 plot
par(mfrow = c(2,2), mar = c(4,4,2,2))
#plotting in rows -> top left, top right, bottom left, bottom right
#1st: Creating an empty plot with specified labels
plot(full_date, as.numeric(data$Global_active_power), type="n", xlab='', ylab='Global Active Power')
#adding line for Global active power vs datetime
lines(full_date, as.numeric(data$Global_active_power))
#2nd: Creating an empty plot with specified labels
plot(full_date, as.numeric(data$Voltage), type="n", xlab='datetime', ylab='Voltage')
#adding line for voltage vs datetime
lines(full_date, as.numeric(data$Voltage))
#3rd creating an empty labeled plot
with(data, plot(full_date, Sub_metering_1, type="n", ylab='Energy sub metering', xlab=''))
#adding 3 lines for each sub metering in different colors
with(data, lines(full_date, Sub_metering_1, col='black'))
with(data, lines(full_date, Sub_metering_2, col='red'))
with(data, lines(full_date, Sub_metering_3, col='blue'))
#adding legend to the top right corner
legend('topright', bty='n', cex=0.7, col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd=1)
#4th creating an empty labeled plot
plot(full_date, as.numeric(data$Global_reactive_power), type="n", xlab='datetime', ylab='Global_reactive_power')
#adding line for Global reactive power vs datetime
lines(full_date, as.numeric(data$Global_reactive_power))
#closing our png device
dev.off()