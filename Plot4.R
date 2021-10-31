##########################################
# Airquality - US PM2.5 Emissions
##########################################
# Plot 4, Question 4
# 4. Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?
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

#unique(SCC$EI.Sector)

# Aggregates the emissions by year, state and EI.Sector
d4 <- aggregate(x = df$Emissions,
                by = list(df$year, df$State, df$EI.Sector),
                FUN = sum)  
names(d4)[names(d4) == "Group.1"] <- "year"
names(d4)[names(d4) == "Group.2"] <- "State"
names(d4)[names(d4) == "Group.3"] <- "EI.Sector"

# Filters on combustion and coal
library("stringr")
d4_comb_coal <- subset(d4, str_detect(d4$EI.Sector, "Comb") & str_detect(d4$EI.Sector, "Coal"))

# Aggregates the emissions by year
d4_comb_coal_year <- aggregate(x = d4_comb_coal$x,
                               by = list(d4_comb_coal$year),
                               FUN = sum)  
names(d4_comb_coal_year)[names(d4_comb_coal_year) == "Group.1"] <- "year"

# Plots and saves a barplot of total emissions by year and coal combustion sources
library(ggplot2)
png("./images/Plot4_Emissions_year_coal_comb.png")
ggplot(d4_comb_coal_year, aes(x =as.factor(year), y=x, fill=as.factor(year)))+
  geom_bar(stat="identity")+
  labs(x = 'Years', y = 'Emissions (tons)', fill="Years",
       title = 'Total PM2.5 Emmissions by year and coal combustion sources',
       subtitle = 'PM2.5 Emissions by coal combustion sources', caption = 'Datasource: publicly available data from Environmental Protection Agency (EPA)')
dev.off()

# Plots and saves a barplot of total emissions by year, coal combustion sources and US states
png("./images/Plot4_Emissions_year_coal_comb_states_2.png")
ggplot(d4_comb_coal, aes(x =as.factor(State), y=x, fill=as.factor(year)))+
  geom_bar(stat="identity")+
  facet_grid(as.factor(year)~.)+
  labs(x = 'US States', y = 'Emissions (tons)', fill="Years",
       title = 'Total PM2.5 Emmissions by year, coal combustion source and US States',
       subtitle = 'PM2.5 Emissions by States', caption = 'Datasource: publicly available data from Environmental Protection Agency (EPA)')
dev.off()