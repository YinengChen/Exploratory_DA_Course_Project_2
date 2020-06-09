# Vehicle

library(ggplot2)
library(tidyverse)

NEI <- readRDS("./data/summarySCC_PM25.rds")%>% janitor::clean_names()
SCC <- readRDS("./data/Source_Classification_Code.rds") %>% janitor::clean_names()

vehicle_scc = SCC$scc[grep("Vehicle",SCC$scc_level_two)] 

vehicle_emi = NEI %>% filter(scc %in% vehicle_scc) %>% 
  filter(fips == "24510")

View(vehicle_emi)

vehicle_emi_year = aggregate(vehicle_emi$emissions, list(vehicle_emi$year), sum)%>% 
  rename(years = Group.1, emissions = x) %>% mutate(years = as.factor(years))

png("plot5.png", width=480, height=480)

ggplot(data = vehicle_emi_year, aes(years)) +
  geom_bar(aes(weight = emissions), fill = "lightpink",width = 0.75) +
  labs(x = "Years", y = "Emissions", 
       title = expression("Total PM"[2.5]*" Emission (10^5 Tons) in Baltimore"))

dev.off()
