library(dplyr)
library(lubridate)
library(data.table)

#dat <- read.csv('household_power_consumption.txt', sep=';', na.strings = '?')
dat <- data.table(read.csv('household_power_consumption.txt', 
                           sep=';', 
                           na.strings = '?', 
                           colClass = c('character', 
                                        'character', 
                                        'numeric', 'numeric', 'numeric', 'numeric', 
                                        'numeric', 'numeric', 'numeric'
                           )
)
)


#extract the 2 days data from 2007-02-01 to 2007-02-02
dt <- filter(dat, 
             as.Date(dat$Date, format ='%d/%m/%Y') >= as.Date('2007-02-01'),
             as.Date(dat$Date, format ='%d/%m/%Y') <= as.Date('2007-02-02')
)
#add a filed that construct POSIXct date time object from fileds Date, Time
dt <- mutate(dt, DateTime = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
rm(dat) #to free memory

Sys.setlocale("LC_TIME", "English") #make the date time shown in English rather default locale

# Plot to a PNG file, default is 480x480, ref:http://www.cookbook-r.com/Graphs/Output_to_a_file/
#

png('plot4.png')
par(mfrow = c(2,2)) # set the device to show plots in 2 by 2 grids, sequence in (row 1,col 1), (row 1, col 2) and so on
with(dt, plot(DateTime,Global_active_power, type = 'l', xlab ='', ylab='Global Active Power'))
with(dt, plot(DateTime, Voltage, type='l', xlab='datetime'))

with(dt, plot(DateTime,Sub_metering_1, type = 'l', xlab ='', ylab='Energy sub metering', col='black'))
with(dt, lines(DateTime,Sub_metering_2, type = 'l', col='red'))
with(dt, lines(DateTime,Sub_metering_3, type = 'l', col='blue'))
with(dt, legend(as.POSIXct('2007-02-01 17:00:00'), 39.5, 
                c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'),
                lty = c(1,1,1),
                col = c('black', 'red','blue'),
                cex = 0.95, #adjust the legend character size
                bty = "n" #legend box without border
))
with(dt, plot(DateTime,Global_reactive_power, type = 'l', xlab ='datetime', ylab='Global_reactive_power'))

dev.off()


