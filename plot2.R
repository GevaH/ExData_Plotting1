rm(list=ls()) # If the previous workspace isn't necessary, I just clear it first.

# Search for folder's existence, create it, download file, unzip it, so on and so forth...
if(!file.exists("./week1")){dir.create("./week1")}
fileUrl  = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileDest = "./week1/week1ProjectData.zip"
download.file(fileUrl, fileDest)
unzip(fileDest,exdir = "./week1")
fileLoc = "./week1/household_power_consumption.txt"

# The next chunk of lines determines the dates we're going to look at, search
# the appropriate lines in the .txt file, read the table from the .txt file
# (only the lines we want), gives names to the columns and extracts the date and
# time information from the table.
firstDate               <- "1/2/2007"
lastDate                <- "^2/2/2007"
firstDateLines          <- grep(firstDate, readLines(fileLoc))
lastDateLines           <- grep(lastDate, readLines(fileLoc))
firstLine               <- min(firstDateLines)
lastLine                <- max(lastDateLines)
numOfLines              <- lastLine - firstLine
projectData             <- read.table(fileLoc, sep = ";",skip = firstLine, nrows = numOfLines)
projectDataNames        <- read.table(fileLoc ,sep = ";", nrows = 1)
projectDataNames        <- as.vector(t(projectDataNames))
colnames(projectData)   <- projectDataNames
timeInfo                <- strptime(paste(as.Date(projectData$Date,'%d/%m/%Y'),projectData$Time), "%Y-%m-%d %H:%M:%S")

# Plotting part.
png(file = "plot2.png") # Defualt is set to 480 x 480 so I just hadn't specified it.
plot(timeInfo,projectData$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()