##########################################
# Course Project 2 - Airquality
##########################################
# Plot 3, Question 3
# 3. Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions 
# from 1999–2008 for Baltimore City? Which have seen 
# increases in emissions from 1999–2008? Use the ggplot2 
# plotting system to make a plot answer this question.
##########################################

## Download the .zip data from 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## and save it into a folder named "data", than unzip it

## Reads the data
NEI <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Aggregates the emissions by year, city codes and source type
d3 <- aggregate(x = NEI$Emissions,
                by = list(NEI$year, NEI$fips, NEI$type),
                FUN = sum)  
names(d3)[names(d3) == "Group.1"] <- "year"
names(d3)[names(d3) == "Group.2"] <- "fips"
names(d3)[names(d3) == "Group.3"] <- "type"

# Filters the Baltimore City data
d3_Baltimore <- subset(d3, fips == "24510")

# Plots and saves a panel with 4 barplots for each source type separately, in Baltimore
library(ggplot2)
png("./images/Plot3_Emissions_by_year_type_Baltimore.png")
ggplot(d3_Baltimore, aes(x =as.factor(year), y=x, fill=as.factor(year)))+
  geom_bar(stat="identity")+
  facet_grid(.~as.factor(type))+
  labs(x = 'Years', y = 'Emissions (tons)', fill="Years",
       title = 'Total PM2.5 Emmissions by year and source type in Baltimore',
       subtitle = 'PM2.5 Emissions source types', caption = 'Datasource: publicly available data from Environmental Protection Agency (EPA)')
dev.off()