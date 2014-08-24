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

BaltCity <- subset(nei, fips == "24510")

TotalYear <- tapply(BaltCity$Emissions, BaltCity$year, sum)

png("plot2.png",width = 480, height = 480)
plot(names(TotalYear), TotalYear, type="l",
     xlab="Year", ylab=expression('Total PM'[2.5]*" Emissions (tons)"),
     main=expression("Total Emission in Baltimore City - 1999 to 2008"))
dev.off()
