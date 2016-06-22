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
png(filename = "plot3.png")
##Create empty plot with "Sub_metering_1" range on y axis
with(housePowerSubset, plot(datetime, Sub_metering_1, type = "n",
                            ylab = "Energy sub metering"))
##Insert 3 lines
with(housePowerSubset, points(datetime, Sub_metering_1, type = "l"))
with(housePowerSubset, points(datetime, Sub_metering_2, type = "l",
                              col = "red"))
with(housePowerSubset, points(datetime, Sub_metering_3, type = "l",
                              col = "blue"))
##Create a legend in topright of the plot
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"))
##Close connection
dev.off()