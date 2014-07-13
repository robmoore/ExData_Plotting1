source("shared.R")

# x-axis: datetime
# y-axis: Voltage
createPlot1B <- function() {
  plot(datetime, 
       data$Voltage,
       ylab = "Voltage", 
       type = "l")
}

# x-axis: datetime 
# y-axis: Global_reactive_power
createPlot2B <- function() {
  plot(datetime, 
       data$Global_reactive_power,
       ylab = names(data)[4],
       type = "l")
}

#  Combine plots
createCombinedPlot <- function() {
  par(mfrow = c(2, 2))
  
  # Plot 1a (same as plot 2 but ylab is slightly different (no killowatts))
  createPlot2("Global Active Power")
  
  # Plot 1b (new)
  createPlot1B()
  
  # Plot 2a (same as 3 but without legend)
  createPlot3(bty = "n") 
  
  # Plot 2b (new)
  createPlot2B()
}

savePlotAsPng("plot4.png", createCombinedPlot)

