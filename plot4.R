########### PLOT 4 #########################################
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


png(file = "plot4.png")

	par(mfrow = c(2,2))

	
	#########TOPRIGHT######
 	plot(mySub$Date, mySub$Global_active_power, col = "black",
	   ylab = "Global Active Power (kilowatts)", xlab="",type ="l")

	#########TOPLEFT######
           plot(mySub$Date, mySub$Voltage, col = "black",
	   ylab = "Voltage", xlab="",type ="l")

	########BOTTOMRIGHTT########
        plot(mySub$Date, mySub$Sub_metering_1, col = "black",
	   ylab = "Energy sub metering", xlab="",type ="l")

	lines(mySub$Date , mySub$Sub_metering_2 , col = "red")
	lines(mySub$Date , mySub$Sub_metering_3 , col = "blue")
	legend("topright", legend = c("Sub_metering_1","Sub_metering_2",
        "Sub_metering_3"),lty=1, col = c("black","red","blue")) 
	#########BOTTOMLEFT######
	
	plot(mySub$Date, mySub$Global_reactive_power, col = "black",ylab = "Global_reactive_power", xlab="",type ="l")

dev.off() 





