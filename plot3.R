library(dplyr)
library(lubridate)

hh_data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")
hh_data <- mutate(hh_data,
                  Date = as.Date(hh_data$Date,format="%d/%m/%Y"),
                  DateTimeStr = paste(hh_data$Date, hh_data$Time, sep=" ")
)

filtered_hh_data <- filter(hh_data,
                           hh_data$Date>=as.Date("01/02/2007", format="%d/%m/%Y"),
                           hh_data$Date<=as.Date("02/02/2007", format="%d/%m/%Y"))

filtered_hh_data <- mutate(filtered_hh_data,
                           DateTime = dmy_hms(filtered_hh_data$DateTimeStr))

png(filename="plot3.png", width = 480, height = 480)
plot(filtered_hh_data$DateTime,
     filtered_hh_data$Sub_metering_1,
     type="n",
     xlab="",
     ylab="Energy sub metering")
lines(filtered_hh_data$DateTime, filtered_hh_data$Sub_metering_1)
lines(filtered_hh_data$DateTime, filtered_hh_data$Sub_metering_2, col="red")
lines(filtered_hh_data$DateTime, filtered_hh_data$Sub_metering_3, col="blue")
legend("topright",
       col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1)
)
dev.off()