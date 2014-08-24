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

## Question 4
## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999-2008?

# Load ggplot2 library
library(ggplot2)

# Extraction of all codes corresponding to coal combustion-related sources

coalscc = scc[grepl("coal", scc$Short.Name, ignore.case=TRUE),]

# Merge two data sets
merge <- merge(x=nei, y=coalscc, by='SCC')
mergesum <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)
colnames(mergesum) <- c('Year', 'Emissions')

png("plot4.png",width = 480, height = 480)

ggplot(data=mergesum, aes(x=Year, y=Emissions)) + 
        geom_line(aes(group=1, col=Emissions)) +  
        ggtitle(expression("Total Emissions From Coal Combustion-related\n Sources in US - 1999 to 2008")) + 
        ylab(expression(paste('PM', ''[2.5], ' in tons'))) + 
        theme(legend.position='none') + scale_colour_gradient(low='black', high='blue')

dev.off()
