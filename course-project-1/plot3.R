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
png("plot3.png", width = 480, height = 480) 

with(hpc_t, {
 plot(Date_Time,  Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="")
 lines(Date_Time, Sub_metering_2, col = "red" )
 lines(Date_Time, Sub_metering_3, col = "blue" )
 legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"),
        # xjust = 1, yjust = 1,
         lty=c(1,1,1) #, seg.len = 1
                )
  })

dev.off()


## Copy  plot to a PNG file
#dev.copy(png, file = "plot3.png")  
#dev.off()

