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

## Question 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
## plot answering this question.

BaltCity <- nei[nei$fips == "24510", ] 

png("plot2.png",width = 480, height = 480)

barplot(tapply(X=BaltCity$Emissions, INDEX=BaltCity$year, FUN=sum), 
        main='Total Emission in Baltimore City, MD', 
        xlab='Year', ylab=expression('PM'[2.5]))

dev.off()