source("shared.R")

# title: Global Active Power
# x axis: Global Active Power (kilowatts)
# y axis: Frequency
# Note: Red bars
createPlot1 <- function() {
  hist(data$Global_active_power, 
       main = "Global Active Power", 
       xlab = gapTitle, 
       col = c("red"))
}

savePlotAsPng("plot1.png", createPlot1)