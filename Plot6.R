##########################################
# Airquality - US PM2.5 Emissions
##########################################
# Plot 6, Question 6
# 6. Compare emissions from motor vehicle sources in 
# Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). Which city has seen greater changes 
# over time in motor vehicle emissions?
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

# Aggregates the emissions by year, city codes, SCC.Level.Two and type
d6 <- aggregate(x = df$Emissions,
                by = list(df$year, df$fips, df$SCC.Level.Two, df$type),
                FUN = sum)  
names(d6)[names(d6) == "Group.1"] <- "year"
names(d6)[names(d6) == "Group.2"] <- "fips"
names(d6)[names(d6) == "Group.3"] <- "SCC.Level.Two"
names(d6)[names(d6) == "Group.4"] <- "type"
d6 <- mutate(d6, State = stringr::str_extract(fips, "^.{2}"))

# Filters on vehicle
d6_veh <- subset(d6, str_detect(d6$SCC.Level.Two, "Vehicle"))

# Filters by Baltimore and Los Angeles
d6_veh_Baltimore <- subset(d6_veh, fips == "24510")
d6_veh_LA <- subset(d6_veh, fips == "06037")

# Aggregates the emissions by year for Baltimore
d6_veh_Baltimore_year <- aggregate(x = d6_veh_Baltimore$x,
                                   by = list(d6_veh_Baltimore$year, d6_veh_Baltimore$fips),
                                   FUN = sum)  
names(d6_veh_Baltimore_year)[names(d6_veh_Baltimore_year) == "Group.1"] <- "year"
names(d6_veh_Baltimore_year)[names(d6_veh_Baltimore_year) == "Group.2"] <- "fips"

# Aggregates the emissions by year for Los Angeles
d6_veh_LA_year <- aggregate(x = d6_veh_LA$x,
                            by = list(d6_veh_LA$year, d6_veh_LA$fips),
                            FUN = sum)  
names(d6_veh_LA_year)[names(d6_veh_LA_year) == "Group.1"] <- "year"
names(d6_veh_LA_year)[names(d6_veh_LA_year) == "Group.2"] <- "fips"

d6_veh_Baltimore_LA <- rbind(d6_veh_Baltimore_year, d6_veh_LA_year)

# Set titles for facets
facetlabs <- c(
  `06037` = "Los Angeles",
  `24510` = "Baltimore")

# Plots and saves a barplot of total emissions by year and motor vehicle sources in Baltimore and Los Angeles
library(ggplot2)
png("./images/Plot6_Emissions_year_vehicle_Baltimore_LA.png")
ggplot(d6_veh_Baltimore_LA, aes(x =as.factor(year), y=x, fill=as.factor(year)))+
  geom_bar(stat="identity")+
  facet_grid(.~as.factor(fips), labeller=as_labeller(facetlabs))+
  labs(x = 'Years', y = 'Emissions (tons)', fill="Years",
       title = 'Total PM2.5 Emmissions in Baltimore and Los Angeles',
       subtitle = 'PM2.5 Emissions from motor vehicle sources', caption = 'Datasource: publicly available data from Environmental Protection Agency (EPA)')
dev.off()