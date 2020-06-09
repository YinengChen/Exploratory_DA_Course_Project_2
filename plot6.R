


library(ggplot2)
library(tidyverse)

NEI <- readRDS("./data/summarySCC_PM25.rds")%>% janitor::clean_names()
SCC <- readRDS("./data/Source_Classification_Code.rds") %>% janitor::clean_names()

vehicle_scc = SCC$scc[grep("Vehicle",SCC$scc_level_two)] 

vehicle_emi_b = NEI %>% filter(scc %in% vehicle_scc) %>% 
  filter(fips=="24510") %>% mutate( fips = as.factor(fips)) %>% 
  mutate(city = rep("Baltimore City"))

vehicle_emi_l = NEI %>% filter(scc %in% vehicle_scc) %>% 
  filter(fips=="06037") %>% mutate( fips = as.factor(fips)) %>% 
  mutate(city = rep("Los Angeles County")) 


vehicle_emi_bl = rbind(vehicle_emi_b,vehicle_emi_l)%>% 
  mutate(city = as.factor(city))

vehicle_emi_year = aggregate(vehicle_emi_bl$emissions, list(vehicle_emi_bl$year,vehicle_emi_bl$city), sum)%>% 
  rename(years = Group.1, city = Group.2, emissions = x) %>% 
  mutate(years = as.factor(years))

png("plot6.png", width=480, height=480)

ggplot(data = vehicle_emi_year,aes(years)) +
  geom_bar(aes(weight = emissions), fill = "chartreuse4",width = 0.75) +
  facet_grid(.~city) + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.off()
