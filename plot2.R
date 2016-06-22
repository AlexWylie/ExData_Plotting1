##Load data set
housePower <- read.table("household_power_consumption.txt", header = T,
                         sep = ";", na.strings = "?")
##Change "Date" column to Date/Time class
housePower$Date <- as.Date(housePower$Date, format = "%d/%m/%Y")
#Create "datetime" column that combines "Date" and "Time" columns
housePower$datetime <- as.POSIXlt(paste(housePower$Date, housePower$Time),
                                  format="%Y-%m-%d %H:%M:%S")
##Load data.table package and subset data set to dates 2007-02-01 - 2007-02-02
if(!require(data.table)) {install.packages("data.table") ; library(data.table)}
housePowerSubset <- housePower[housePower$Date %between% c("2007-02-01",
                                                           "2007-02-02"),]
##Open png connection
png(filename = "plot2.png")
plot(housePowerSubset$datetime, housePowerSubset$Global_active_power,
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
##Close connection
dev.off()