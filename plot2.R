# Have total emissions from PM2.5 decreased 
# in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make 
# a plot answering this question.

library(tidyverse)
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI_bal = NEI %>% filter(fips == "24510") %>% group_by(year)
emi_Bal = tapply(NEI_bal$Emissions,NEI_bal$year,sum) 

png("plot2.png", width=480, height=480)

barplot(emi_Bal, xlab = "Years", ylab = "Emissions", 
        main = "Emissions over the Years in  Baltimore City, Maryland ")

dev.off()
