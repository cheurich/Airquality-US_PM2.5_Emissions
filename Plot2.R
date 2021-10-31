##########################################
# Airquality - US PM2.5 Emissions
##########################################
# Plot 2, Question 2
# 2. Have total emissions from PM2.5 decreased in the 
# Baltimore City, Maryland (fips == "24510") from 1999 
# to 2008? Use the base plotting system to make a plot 
# answering this question.
##########################################

## Download the .zip data from 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## and save it into a folder named "data", than unzip it

## Reads the data
NEI <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Aggregates the emissions by year and by city codes
d2 <- aggregate(x = NEI$Emissions,
                by = list(NEI$year, NEI$fips),
                FUN = sum)  
names(d2)[names(d2) == "Group.1"] <- "year"
names(d2)[names(d2) == "Group.2"] <- "fips"

# Filters the Baltimore City data
d2_Baltimore <- subset(d2, fips == "24510")

# Plots and saves a barplot of total emissions by year in Baltimore City, Maryland
png("./images/Plot2_Emissions_by_year_Baltimore.png")
barplot(d2_Baltimore$x, d2_Baltimore$year, names.arg = d2_Baltimore$year, xlab="Years", ylab = "Emissions (tons)", main="Total PM2.5 Emissions by year in Baltimore")
dev.off()