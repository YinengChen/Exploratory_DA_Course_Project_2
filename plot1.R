# Question 1
# Have total emissions from PM2.5 decreased 
# in the United Statesfrom 1999 to 2008? 
# Using the base plotting system, make a 
# plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

library(tidyverse)
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI = NEI %>% group_by(year)

emi_year = tapply(NEI$Emissions,NEI$year,sum) 

png("plot1.png", width=480, height=480)


barplot(emi_year, xlab = "Years", ylab = "Emissions", main = "Emissions over the Years")

dev.off()
