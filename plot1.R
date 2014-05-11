#download the data

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "Raw_Data.zip", method = "curl")
unzip("Raw_Data.zip") #unzip the file

#Load the data
raw_data <- read.table("household_power_consumption.txt", sep=";",stringsAsFactors=FALSE,header=TRUE)
raw_data$Date<-strptime(raw_data$Date, format= "%d/%m/%Y") #Convert the date format

#subset data for plots
data_for_plot<-subset(raw_data, as.Date(Date)=="2007-02-01"|as.Date(Date)=="2007-02-02") 

#Plot 1
png("plot1.png", width = 480, height = 480 )
plot1<-hist(as.numeric(data_for_plot$Global_active_power),col="red",
            xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()