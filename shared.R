maybeDownload.file <- function(dataFileUrl, dataFile) {
  if (!file.exists(dataFile)) { 
    # This assumes that curl is installed. Probably won't work on Windows.
    download.file(url=dataFileUrl, destfile=dataFile, method="curl") 
  }
}

savePlotAsPng <- function(filename, plotFunc, wd = 504, ht = 504) {
  png(filename, width = wd, height = ht, bg = "transparent")

  plotFunc()
  
  dev.off()
}

# Convert using day/month/year format
setAs("character", "dmyDate", function(from) as.Date(from, format="%d/%m/%Y"))
setClass("dmyDate")

loadData <- function() {
  dataFile <- "household_power_consumption.zip"
  
  dataFileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  
  maybeDownload.file(dataFileUrl, dataFile)
  
  # Note that in this dataset missing values are coded as ?.
  read.table(unz(dataFile, "household_power_consumption.txt"), 
             sep = ";", 
             header = TRUE, 
             na.strings = "?", 
             colClasses = c(Date = "dmyDate", "factor", rep("numeric", 7)))
}

data <- loadData()

# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data
# from just those dates rather than reading in the entire dataset and subsetting to those dates.
data <- data[data$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]

gapTitle <- "Global Active Power (kilowatts)"

# Combination of date and time for series
datetime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %T")

# x axis: days (Thu, Fri, Sat)
# y axis: "Global Active Power (kilowatts)
createPlot2 <- function(ylab = gapTitle) {
  plot(datetime, 
       data$Global_active_power, 
       ylab = ylab, 
       xlab = "", 
       type = "l")
}

# x axis: none
# y axis: Energy sub metering
# 
# Includes legend:
#- sub metering 1: black
#- sub metering 2: red
#- sub metering 3: blue
createPlot3 <- function(bty = "o") {
  plot(datetime, 
       data$Sub_metering_1,
       ylab = "Energy sub metering", 
       xlab = "", 
       type = "l")
  
  lines(dateTime, data$Sub_metering_2, col = "red")
  lines(dateTime, data$Sub_metering_3, col = "blue")
  
  legend("topright", lty = 1, col = c("black", "blue", "red"), legend = names(data)[7:9], bty = bty)
}

