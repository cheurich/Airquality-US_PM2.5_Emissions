##########################################
# Airquality - US PM2.5 Emissions
##########################################
# Plot 1, Question 1
# 1. Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the 
# total PM2.5 emission from all sources for each of the years 1999, 2002, 
# 2005, and 2008.
##########################################

## Download the .zip data from 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## and save it into a folder named "data", than unzip it

## Reads the data
NEI <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds")
dim(NEI) # 6497651       6
dim(SCC) # 11717    15

# Aggregates the emissions by year
d1 <- aggregate(x = NEI$Emissions,
                by = list(NEI$year),
                FUN = sum)  
names(d1)[names(d1) == "Group.1"] <- "year"
head(d1)

# Plots and saves a barplot of total emissions by year
png("./images/Plot1_Emissions_by_year.png")
barplot(d1$x, d1$year, names.arg = d1$year, xlab="Years", ylab = "Emissions (tons)", main="Total PM2.5 emissions by year: 1999, 2002, 2005, 2008")
dev.off()