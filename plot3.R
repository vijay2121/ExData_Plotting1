#This R script reads the data between 2007-02-01 and 2007-02-02 and plots the graph.
#The graph's X-Axis is Date and Time Y-Axis is Energy Sub Metering data

plotGraph3()
 
plotGraph3<-function()
{
        data<-readData()        
        png(file="plot3.png")        
        with(data,plot(data$dateAndTime,data$Sub_metering_1,col="black", type="s",ylab="Energy sub metering", xlab=""))
        with(data,points(data$dateAndTime,data$Sub_metering_2,col="red", type="s"))
        with(data,points(data$dateAndTime,data$Sub_metering_3,col="blue", type="s"))
        legend("topright",lty=c(1,1,1),col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
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