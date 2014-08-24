## Downloading data

url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destino <- "exdata-data-NEI_data.zip"

download.file(url, destino)

sourcefile <- unzip(destino)

if (!"nei" %in% dir()) {
        nei <- readRDS("summarySCC_PM25.rds")
}
if (!"scc" %in% dir()) {
        scc <- readRDS("Source_Classification_Code.rds")
}

## Question 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 
## 2008? Using the base plotting system, make a plot showing the total PM2.5 
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.


total <- aggregate(nei[, 'Emissions'], by=list(nei$year), FUN=sum)

png("plot1.png", width = 480, height = 480)

barplot(total$x, names.arg=total$Group.1, 
        main=expression('Total Emissions in US - 1999 to 2008'), 
        xlab='Year',ylab=expression('Total PM'[2.5]*" Emissions (tons)"))

dev.off()