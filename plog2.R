source("shared.R")

# title: none
# x axis: days (Thu, Fri, Sat)
# y axis: "Global Active Power (kilowatts)
savePlotAsPng("plot2.png", function() {
  dateTime <- strptime(paste(data$Date,data$Time), format = "%Y-%m-%d %T")
  plot(dateTime, data$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l",  )
})