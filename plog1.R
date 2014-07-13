source("shared.R")

# title: Global Active Power
# x axis: Global Active Power (kilowatts)
# y axis: Frequency
# Note: Red bars
savePlotAsPng("plot1.png", function() {
  hist(data$Global_active_power, 
       main="Global Active Power", 
       xlab = "Global Active Power (kilowatts)", 
       col = c("red"))
})