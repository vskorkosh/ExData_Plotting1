#This R script will plot Global Active Power against the time

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
png('plot2.png')
#Creating an empty plot with specified labels
plot(full_date, as.numeric(data$Global_active_power), type="n", xlab='', ylab='Global Active Power (kilowatts)')
#adding line, specified by our points, not sure what that color is, but I'll use gray
lines(full_date, as.numeric(data$Global_active_power), col='gray')
#closing our png device
dev.off()