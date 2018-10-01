library(tidyverse)
library(lubridate)


hpc <- read_delim("household_power_consumption.txt", ";",
                  col_types = c("ccccccccc"))


hpc$Date_Time <-  dmy_hms(paste(hpc$Date, " ", hpc$Time))

hpc <- hpc[,c(10,3:9)]

hpc_t <- filter(hpc,  Date_Time >= as.Date("01022007", "%d%m%Y") &
                    Date_Time  < as.Date("03022007", "%d%m%Y")    
              )

hpc_t$Global_active_power <- as.numeric(hpc_t$Global_active_power)

hpc_t$Sub_metering_1 <- as.numeric(hpc_t$Sub_metering_1)
hpc_t$Sub_metering_2 <- as.numeric(hpc_t$Sub_metering_2)
hpc_t$Sub_metering_3 <- as.numeric(hpc_t$Sub_metering_3)



#windows(width = 480, height = 480) 
png("plot4.png", width = 480, height = 480) 

par(mfrow = c (2,2))
#
plot( hpc_t$Date_Time, hpc_t$Global_active_power, type = "l",
      ylab = "Global Active Power", xlab = ""  )
#
plot( hpc_t$Date_Time, hpc_t$Voltage, type = "l",
      ylab = "Voltage", xlab = "datetime"  )
#
with(hpc_t, {
 plot(Date_Time,  Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="")
 lines(Date_Time, Sub_metering_2, col = "red" )
 lines(Date_Time, Sub_metering_3, col = "blue" )
 
 legend(   "topright"
   ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
   , col = c("black", "red", "blue"), lty=c(1,1,1) 
   , bty = "n" #, seg.len = 1
  # , inset = -0.11
  # , y.intersp = 0.3 
  # , x.intersp = -1.5
  # , adj = c(-0.7, 0) 
  # , trace = TRUE 
  )      })
#
plot( hpc_t$Date_Time, hpc_t$Global_reactive_power, type = "l",
      ylab = "Global_reactive_power", xlab = "datetime"  )

dev.off()

## Copy  plot to a PNG file
#dev.copy(png, file = "plot4.png")  
#dev.off()

