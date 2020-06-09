library(ggplot2)
library(tidyverse)

NEI <- readRDS("./data/summarySCC_PM25.rds")%>% janitor::clean_names()
SCC <- readRDS("./data/Source_Classification_Code.rds") %>% janitor::clean_names()

coal_num = SCC$scc[grep("Coal",SCC$short_name)] 
coal_emi = NEI %>% filter(scc %in% coal_num)

coal_emi_year = aggregate(coal_emi$emissions, list(coal_emi$year), sum)%>% 
  rename(years = Group.1, emissions = x) %>% mutate(years = as.factor(years))

png("plot4.png", width=480, height=480)

ggplot(data = coal_emi_year, aes(years)) +
  geom_bar(aes(weight = emissions),fill = "darksalmon",width = 0.75) +
  labs(x = "Years", y = "Emissions", 
       title = expression("Total PM"[2.5]*" Emission (10^5 Tons)"))

dev.off()
