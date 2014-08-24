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

## Question 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, 
## nonroad) variable, which of these four sources have seen decreases in 
## emissions from 1999-2008 for Baltimore City? Which have seen increases in 
## emissions from 1999-2008? Use the ggplot2 plotting system to make a plot 
## answer this question.

# Load ggplot2 library
library(ggplot2)

BaltCity <- nei[nei$fips == "24510", ] 

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png("plot3.png",width = 480, height = 480)
g <- ggplot(BaltCity, aes(year, Emissions, color = type))
g  +geom_line(stat = "summary", fun.y = "sum") + 
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle("Total Emissions per Type in Baltimore City - 1999 to 2008")
dev.off()
