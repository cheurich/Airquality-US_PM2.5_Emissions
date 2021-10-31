CodeBook
================
Airquality - US PM2.5 Emissions





# 1. Intro

Fine particulate matter (PM2.5) is an ambient air pollutant for which
there is strong evidence that it is harmful to human health. In the
United States, the Environmental Protection Agency (EPA) is tasked with
setting national ambient air quality standards for fine PM and for
tracking the emissions of this pollutant into the atmosphere.
Approximatly every 3 years, the EPA releases its database on emissions
of PM2.5. This database is known as the National Emissions Inventory
(NEI). You can read more information about the NEI at the EPA National
Emissions Inventory web site.

For each year and for each type of PM source, the NEI records how many
tons of PM2.5 were emitted from that source over the course of the
entire year. The data that you will use for this assignment are for
1999, 2002, 2005, and 2008.

# 2. Data

The data for this assignment are available from the course web site as a
single zip file:

-   Data for Peer Assessment (29Mb):
    <https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip>

The zip file contains two files:

PM2.5 Emissions Data (summarySCC\_PM25.rds): This file contains a data
frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and
2008. For each year, the table contains number of tons of PM2.5 emitted
from a specific type of source for the entire year. Here are the first
few rows.

NEI Dataframe 

    ##     fips      SCC Pollutant Emissions  type year
    ## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
    ## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
    ## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
    ## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
    ## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
    ## 24 09001 10200602  PM25-PRI     1.490 POINT 1999

-   *“fips:”* A five-digit number (represented as a string) \#indicating
    the U.S. county

-   *“SCC:”* The name of the source as indicated by a digit string
    \#(see source code classification table)

-   *“Pollutant:”* A string indicating the pollutant

-   *“Emissions:”* Amount of PM2.5 emitted, in tons

-   *“type:”* The type of source (point, non-point, on-road, or
    \#non-road)

-   *“year:”* The year of emissions recorded

Source Classification Code Table (“Source\_Classification\_Code.rds”):
This table provides a mapping from the SCC digit strings in the
Emissions table to the actual name of the PM2.5 source. The sources are
categorized in a few different ways from more general to more specific
and you may choose to explore whatever categories you think are most
useful. For example, source “10100101” is known as “Ext Comb /Electric
Gen /Anthracite Coal /Pulverized Coal”.

You can read each of the two files using the readRDS() function in R.
For example, reading in each file can be done with the following code:

NEI &lt;- readRDS(“summarySCC\_PM25.rds”)

NEI Variables

    ## 'data.frame':    6497651 obs. of  6 variables:
    ##  $ fips     : chr  "09001" "09001" "09001" "09001" ...
    ##  $ SCC      : chr  "10100401" "10100404" "10100501" "10200401" ...
    ##  $ Pollutant: chr  "PM25-PRI" "PM25-PRI" "PM25-PRI" "PM25-PRI" ...
    ##  $ Emissions: num  15.714 234.178 0.128 2.036 0.388 ...
    ##  $ type     : chr  "POINT" "POINT" "POINT" "POINT" ...
    ##  $ year     : int  1999 1999 1999 1999 1999 1999 1999 1999 1999 1999 ...

SCC &lt;- readRDS(“Source\_Classification\_Code.rds”)

SCC Variables

    ## 'data.frame':    11717 obs. of  15 variables:
    ##  $ SCC                : Factor w/ 11717 levels "10100101","10100102",..: 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ Data.Category      : Factor w/ 6 levels "Biogenic","Event",..: 6 6 6 6 6 6 6 6 6 6 ...
    ##  $ Short.Name         : Factor w/ 11238 levels "","2,4-D Salts and Esters Prod /Process Vents, 2,4-D Recovery: Filtration",..: 3283 3284 3293 3291 3290 3294 3295 3296 3292 3289 ...
    ##  $ EI.Sector          : Factor w/ 59 levels "Agriculture - Crops & Livestock Dust",..: 18 18 18 18 18 18 18 18 18 18 ...
    ##  $ Option.Group       : Factor w/ 25 levels "","C/I Kerosene",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Option.Set         : Factor w/ 18 levels "","A","B","B1A",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ SCC.Level.One      : Factor w/ 17 levels "Brick Kilns",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ SCC.Level.Two      : Factor w/ 146 levels "","Agricultural Chemicals Production",..: 32 32 32 32 32 32 32 32 32 32 ...
    ##  $ SCC.Level.Three    : Factor w/ 1061 levels "","100% Biosolids (e.g., sewage sludge, manure, mixtures of these matls)",..: 88 88 156 156 156 156 156 156 156 156 ...
    ##  $ SCC.Level.Four     : Factor w/ 6084 levels "","(NH4)2 SO4 Acid Bath System and Evaporator",..: 4455 5583 4466 4458 1341 5246 5584 5983 4461 776 ...
    ##  $ Map.To             : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Last.Inventory.Year: int  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Created_Date       : Factor w/ 57 levels "","1/27/2000 0:00:00",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Revised_Date       : Factor w/ 44 levels "","1/27/2000 0:00:00",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Usage.Notes        : Factor w/ 21 levels ""," ","includes bleaching towers, washer hoods, filtrate tanks, vacuum pump exhausts",..: 1 1 1 1 1 1 1 1 1 1 ...

as long as each of those files is in your current working directory
(check by calling dir() and see if those files are in the listing).
