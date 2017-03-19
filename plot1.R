
producePlot1 <- function (inputfile = "./data/household_power_consumption.txt", outputfile = "plot1.png"){
  
  # constants
  date.start <- strptime(c("01/02/2007 00:00:00"),"%d/%m/%Y %H:%M:%S")
  date.end <- strptime(c("02/02/2007 23:59:59"),"%d/%m/%Y %H:%M:%S")
  
  # read data
  print("Reading dataset...")
  ds <- read.table("./data/household_power_consumption.txt", header=TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")
  
  # create new column convert date and time to POSIXlt
  print("Convert date and time columns...")
  ds$DateTime <- paste(ds$Date, ds$Time)
  ds$DateTime <- strptime(ds$DateTime,"%d/%m/%Y %H:%M:%S")
  ds$Date <- NULL
  ds$Time <- NULL
  
  # select only data from relevant date and remove NAs
  print("Select dates 01/02/2007-02/02/2007...")
  ds <- ds[ds$DateTime >= date.start & ds$DateTime <= date.end & !is.na(ds$DateTime),]
  
  # define png device
  print("Plot histogram")
  png(file="plot1.png", 
      width = 480,
      height = 480)
  
  # draw histogram
  hist(ds$Global_active_power, 
       main = "Global Active Power",
       xlab = "Global Active Power (kilowatts)",
       col = "red")
  
  # close device
  dev.off()
  
  print("Finished")
}


# Create plot 1 and write to png file
producePlot1()