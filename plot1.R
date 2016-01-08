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

png('plot1.png')
hist(dt$Global_active_power, col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)')
dev.off()
