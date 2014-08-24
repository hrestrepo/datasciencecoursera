## Downloading data

url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destino <- "exdata-data-NEI_data.zip"

download.file(url, destino)

sourcefile <- unzip(destino)

## Loading data

if (!"nei" %in% dir()) {
        nei <- readRDS("summarySCC_PM25.rds")
}
if (!"scc" %in% dir()) {
        scc <- readRDS("Source_Classification_Code.rds")
}

## Question 5
## How have emissions from motor vehicle sources changed from 1999-2008 in 
## Baltimore City?

# Load ggplot2 library
library(ggplot2)

# Subsetting data
BaltCity <- nei[nei$fips == "24510", ] 

# Taking ON-ROAD as the motor Vehicles sources
BaltVeh <- BaltCity[BaltCity$type == "ON-ROAD", ]
TotBaltData <- aggregate(BaltVeh$Emissions, by = list(BaltVeh$year), FUN = sum)

## Plotting data

png("plot5.png",width = 480, height = 480)

ggplot(TotBaltData, aes(Group.1, x)) + 
        geom_line() + 
        labs(title = "Baltimore Motor Vehicles' Emissions\n 1999 to 2008", 
             x = "Year", y = expression("PM" [2.5] ~ "Emitted (tons)"))
dev.off()


