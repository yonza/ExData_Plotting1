########### PLOT 3 #########################################
# Reading in the table, defining classes
# and setting <?> as an NA. 
# For now the time/date are classed as text.
# Note that the "household_power_consumption.txt" file must 
# be in your working directory for the code to run properly 
###########################################################




powData <- read.table("household_power_consumption.txt", 
           colClasses = c("character","character","numeric","numeric",
                        "numeric","numeric","numeric","numeric","numeric"),
           na.strings = "?", sep =";", header = TRUE)


###########
# Past together date and time variables and convert it into a 
# single variable of POSIXct class.  POSIXct rather POSIXlt since
# lt is a class=list so I can put it into data frame
###########


# (1) paste together date/time strings (2) convert to POSIXlt (3) convert to posixCT

myTime <- as.POSIXct(
		     strptime( paste(powData$Date, " ", powData$Time), 

		               "%d/%m/%Y %H:%M:%S")
		    )  


powData[,1] <- myTime #puts myTime into the first column of powData


###########
# We are only getting data from 2007-02-01 to 2007-02-02
###########

mySub <- powData[ as.Date(powData[,1]) == as.Date("2007-02-01") | 
		  as.Date(powData[,1]) == as.Date("2007-02-02") , ]



###########
#PLOT 1
###########


png(file = "plot3.png")

        plot(mySub$Date, mySub$Sub_metering_1, col = "black",
	   ylab = "Energy sub metering", xlab="",type ="l")

	lines(mySub$Date , mySub$Sub_metering_2 , col = "red")
	lines(mySub$Date , mySub$Sub_metering_3 , col = "blue")
	legend("topright", legend = c("Sub_metering_1","Sub_metering_2",
        "Sub_metering_3"),lty=1, col = c("black","red","blue")) 
dev.off() 




