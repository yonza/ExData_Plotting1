########### PLOT 2 #########################################
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


png(file = "plot2.png")

        plot(mySub$Date, mySub$Global_active_power, col = "black",
	   ylab = "Global Active Power (kilowatts)", xlab="",type ="l")
dev.off() 



