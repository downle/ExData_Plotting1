#download the data
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "Raw_Data.zip", method = "curl")
unzip("Raw_Data.zip") #unzip the file

#Load the data
raw_data <- read.table("household_power_consumption.txt", sep=";",stringsAsFactors=FALSE,
                       header=TRUE)
raw_data$Date<-strptime(raw_data$Date, format= "%d/%m/%Y") #Convert the date format

#subset data for plots
data_for_plot<-subset(raw_data, as.Date(Date)=="2007-02-01"|as.Date(Date)=="2007-02-02") 

#Plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2)) # 4 figures arranged in 2 rows and 2 columns

#Top left
data_for_plot$Datetime<-as.POSIXct(paste(data_for_plot$Date, data_for_plot$Time), 
                                   format="%Y-%m-%d %H:%M:%S") #Create datetime variable
plot1<-plot(data_for_plot$Datetime,as.numeric(data_for_plot$Global_active_power),
            type="l",xlab="",ylab="Global Active Power (kilowatts)")

#Top right
plot2<-plot(data_for_plot$Datetime,as.numeric(data_for_plot$Voltage),type="l",
            xlab="datetime",ylab="Voltage")

#bottom left
plot3<-plot(data_for_plot$Datetime,as.numeric(data_for_plot$Sub_metering_1),type="n",
            xlab="",ylab="Energy sub metering") #Initial plot
points(data_for_plot$Datetime,as.numeric(data_for_plot$Sub_metering_1),
       type="l") #Sub_metering_1
points(data_for_plot$Datetime,as.numeric(data_for_plot$Sub_metering_2),
       type="l",col="red") #Sub_metering_2
points(data_for_plot$Datetime,as.numeric(data_for_plot$Sub_metering_3),
       type="l",col="blue") #Sub_metering_3
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,
       col=c("black","red","blue"),bty = "n",cex=0.7)

#bottom right
plot4<-plot(data_for_plot$Datetime,as.numeric(data_for_plot$Global_reactive_power),
            type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off()
