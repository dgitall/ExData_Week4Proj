# Create an exploratory plot to show how  emissions from coal 
# combustion-related sources changed from 1999–2008 across the United States 

library(ggplot2)


NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

# Make a vector of all of the SCC's with 'Coal' in their name
coalSCC <- SCC[grep("Coal", SCC$Short.Name),]
# subset out only those sources from the full US dataset
coalNEI <- subset(NEI, NEI$SCC %in% coalSCC$SCC)
totalCoalPM25 <- data.frame(Emissions = with(coalNEI, tapply(Emissions, year, 
                                                sum, na.rm=TRUE)), 
                        Year = c("1999", "2002", "2005", "2008"))

## Plot the total emissions by year for coal related sources
g <- ggplot(totalCoalPM25, aes(x=Year, y=Emissions/100000, group=1)) +
  geom_point(size = 2) +
  geom_line(size = 1.1, linetype=3) + 
  labs(title = "Total U.S PM25 Emissions From Coal Decrease Over Time",
       x = "",
       y = "PM25 Emissions (100,000 tons)")  
print(g)

dev.copy(png,filename="Plot4.PNG")
dev.off ()

