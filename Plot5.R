##########################################
# Course Project 2 - Airquality
##########################################
# Plot 5, Question 5
# 5. How have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City?
##########################################

## Download the .zip data from 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## and save it into a folder named "data", than unzip it

# Reads the data
NEI <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Merges together the NEI and SCC dataframes
df <- merge(NEI, SCC, by="SCC")

# Extract the first 2 characters from city codes
library("dplyr")
df <- mutate(df, State = stringr::str_extract(fips, "^.{2}"))

#unique(SCC$SCC.Level.Two)

# Aggregates the emissions by year, city codes and SCC.Level.Two
d5 <- aggregate(x = df$Emissions,
                by = list(df$year, df$fips, df$SCC.Level.Two),
                FUN = sum)  
names(d5)[names(d5) == "Group.1"] <- "year"
names(d5)[names(d5) == "Group.2"] <- "fips"
names(d5)[names(d5) == "Group.3"] <- "SCC.Level.Two"

# Filters on vehicle
library("stringr")
d5_veh <- subset(d5, str_detect(d5$SCC.Level.Two, "Vehicle"))

# Filters by Baltimore
d5_veh_Baltimore <- subset(d5_veh, fips == "24510")

# Aggregates the emissions from Baltimore vehicle sources by year
d5_veh_Baltimore_year <- aggregate(x = d5_veh_Baltimore$x,
                               by = list(d5_veh_Baltimore$year),
                               FUN = sum)  
names(d5_veh_Baltimore_year)[names(d5_veh_Baltimore_year) == "Group.1"] <- "year"

# Plots and saves a barplot of total emissions by year and coal combustion sources
library(ggplot2)
png("./images/Plot5_Emissions_year_vehicle_Baltimore.png")
ggplot(d5_veh_Baltimore_year, aes(x =as.factor(year), y=x, fill=as.factor(year)))+
  geom_bar(stat="identity")+
  labs(x = 'Years', y = 'Emissions (tons)', fill="Years",
       title = 'Total PM2.5 Emmissions by year and motor vehicle sources in Baltimore',
       subtitle = 'PM2.5 Emissions from motor vehicle sources', caption = 'Datasource: publicly available data from Environmental Protection Agency (EPA)')
dev.off()