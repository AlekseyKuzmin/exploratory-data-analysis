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


plot(hpc_t$Date_Time, hpc_t$Global_active_power,  type = "l",
     ylab = "Global Active Power (kilowatts)", xlab=""
     )

## Copy  plot to a PNG file
dev.copy(png, file = "plot2.png")  
dev.off()

