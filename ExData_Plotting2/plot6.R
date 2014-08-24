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

## Question 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California (fips == "06037").
## Which city has seen greater changes over time in motor vehicle emissions?


MotorVeh_Balt_LA <- subset(nei, (fips == "24510" | fips == "06037") & type=="ON-ROAD")

png("plot6.png",width = 480, height = 480,bg = "transparent")

g <- ggplot(MotorVeh_Balt_LA, aes(year, Emissions, color = fips))
g + geom_line(stat = "summary", fun.y = "sum") +
        ylab(expression('Total PM'[2.5]*" Emissions (tons)")) +
        ggtitle(" Comparision of Emissions from Motor Vehicle Sources in\n Baltimore City and Los Angeles County\n 1999 to 2008") +
        scale_colour_discrete(name = "City", label = c("Los Angeles County","Baltimore City"))
dev.off()
