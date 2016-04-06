plot2 <- function(){
      # these 4 lines will download and unzip, to get .txt in folder.
      cat("Downloading and unzipping file...\n")
      zipFileName <- "exdata-data-household_power_consumption.zip"
      fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      zipfile <- download.file(fileUrl, destfile =zipFileName, method="curl")
      unzip(zipFileName) #at this point have .txt in working directory
      
      # assuming have the .txt file in working directory
      cat("Reading data into data frame...\n")
      txtFileName <- "household_power_consumption.txt"
      y <- c("character", "character", rep("numeric", 7))
      data <- read.table(txtFileName, header=TRUE, sep=";", na.strings="?", colClasses=y)
      
      # subset for the desired two days
      days <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
      
      # join date and time columns and convert to special date form
      days$Date <- paste(days$Date, days$Time)
      days$Time <- NULL
      days$Date <- strptime(days$Date, "%d / %m / %Y %H : %M : %S")
      
      # make Plot 2 and save to PNG file
      plotfile <- "plot2.png"
      png(filename = plotfile)
      plot(days$Date, days$Global_active_power, pch=20, ylab="Global Active Power (kilowatts)", xlab="", type="n")
      lines(days$Date, days$Global_active_power, lwd=2)
      dev.off()
      cat("Plot saved to ", plotfile, ".", sep ="")
}
