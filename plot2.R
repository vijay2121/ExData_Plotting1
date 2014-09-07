#This R script reads the data between 2007-02-01 and 2007-02-02 and plots the graph.
#The graph's X-Axis is Date and Time Y-Axis is Global Active Power(killowatts)

plotGraph2()

plotGraph2<-function()
{
        data<-readData()        
        png(file="plot2.png")
        plot(data$dateAndTime, data$Global_active_power, type="l",  ylab="Global Active Power (killowatts)", xlab="")                
        dev.off()
}

readData<-function()
{
        #To optimize the reading, read first few rows, idetify the classes of columns and pass as input to read.table()
        fewRows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 5, na.strings="?", sep=";")
        classes <- sapply(fewRows, class)
        content <- read.table("household_power_consumption.txt", header = TRUE, colClasses = classes, nrows=2075259, na.strings="?", sep=";")        
        #Convert to Date object
        content[,1]<-as.Date(content[,1], format="%d/%m/%Y")
        #t1<-strptime(paste(c[1,1],c[1,2]),format="%d/%m/%Y %H:%M:%S", tz="GMT")
        #Extract only the required data
        data<-content[content$Date == as.Date("2007-02-01") | content$Date == as.Date("2007-02-02"),]
        dateAndTime<-strptime(paste(data[,1],data[,2]),format="%Y-%m-%d %H:%M:%S", tz="GMT")        
        data2<-cbind(data,dateAndTime)
        data2
}