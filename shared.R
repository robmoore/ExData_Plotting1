maybeDownload.file <- function(dataFileUrl, dataFile) {
  if (!file.exists(dataFile)) { 
    download.file(url=dataFileUrl, destfile=dataFile, method="curl") 
  }
}

savePlotAsPng <- function(filename, plotFunc) {
  png(filename)

  plotFunc()
  
  dev.off()
}

# Convert using day/month/year format
setAs("character","dmyDate", function(from) as.Date(from, format="%d/%m/%Y") )

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

