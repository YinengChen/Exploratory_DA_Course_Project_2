library(ggplot2)
library(tidyverse)

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI_bal = NEI %>% filter(fips == "24510") %>% group_by(year)

emi_Bal = aggregate(NEI_bal$Emissions, list(NEI_bal$year,NEI_bal$type), sum) %>% 
  rename(
    years = Group.1,
    type = Group.2,
    emissions = x
  )

png("plot3.png", width=480, height=480)

ggplot(data = emi_Bal, aes(x = years, y = emissions,color = type)) +
  geom_line() +
  labs(x = "Years", y = "Emissions", 
       title = "Emissions over the Years in Baltimore City, Maryland by type ")

dev.off()
