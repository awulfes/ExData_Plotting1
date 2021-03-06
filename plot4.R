
producePlot4 <- function (inputfile = "./data/household_power_consumption.txt", outputfile = "plot2.png"){
  
  # constants
  date.start <- strptime(c("01/02/2007 00:00:00"),"%d/%m/%Y %H:%M:%S")
  date.end <- strptime(c("02/02/2007 23:59:59"),"%d/%m/%Y %H:%M:%S")
  
  # read data
  print("Reading dataset...")
  ds <- read.table(inputfile, header=TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")
  
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
  print("Plot line graph")
  png(file=outputfile, 
      width = 480,
      height = 480)
  
  # draw line graph
  Sys.setlocale("LC_TIME", "C")
  
  # set for multiple plots
  par(mfcol=c(2,2))
  
  # plot 1
  plot(ds$DateTime, ds$Global_active_power, 
       type="l",
       ylab = "Global Active Power (kilowatts)",
       xlab = "")
  
  # plot 2
  # create initial plot and draw black line for metering_1
  plot(ds$DateTime, ds$Sub_metering_1, 
       type="l",
       ylab = "Energy sub metering",
       xlab = "",
       col = "black"
  )
  # draw red line for metering_2
  lines(ds$DateTime, ds$Sub_metering_2, 
        type="l",
        col = "red"
  )
  # draw red line for metering_3
  lines(ds$DateTime, ds$Sub_metering_3, 
        type="l",
        col = "blue"
  ) 
  # add legend
  legend("topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lwd=1,
         col = c("black", "red", "blue"),
         bty = "n"
  )
  
  # plot 3
  plot(ds$DateTime, ds$Voltage, 
       type = "l",
       xlab = "datetime",
       ylab = "Voltage")
  
  # plot 4
  plot(ds$DateTime, ds$Global_reactive_power, 
       type = "l",
       xlab = "datetime",
       ylab = "Global_reactive_power")
  
  
  # close device
  dev.off()
  
  print("Finished")
}


# Create plot 4 and write to png file
# Please override with location of data set and desired output file
producePlot4(inputfile = "./data/household_power_consumption.txt", outputfile = "plot4.png")