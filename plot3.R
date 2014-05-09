#This R script plots sub meterings

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
png('plot3.png')
#creating an empty labeled plot
with(data, plot(full_date, Sub_metering_1, type="n", ylab='Energy sub metering', xlab=''))
#adding 3 lines for each sub metering in different colors
with(data, lines(full_date, Sub_metering_1, col='black'))
with(data, lines(full_date, Sub_metering_2, col='red'))
with(data, lines(full_date, Sub_metering_3, col='blue'))
#adding legend to the top right corner
legend('topright', col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd=1)
#closing our png device
dev.off()