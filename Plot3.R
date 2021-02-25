# Create an exploratory plot using ggplot2 to show how  emissions from the four  
# types of sources (point, nonpoint, on road, and non-road) have changed 
# from 1999–2008 in Baltimore City 
library(ggplot2)


NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

## Calculate the sum of all emissions for each year
Year <- c("1999", "2002", "2005", "2008")
BaltNEI <- subset(NEI, fips == "24510")
BaltPoint <- subset(BaltNEI, type == "POINT")
pm25Point <- data.frame(Emissions = with(BaltPoint, tapply(Emissions, year,
                                               sum, na.rm=TRUE)),
                        Year = Year)
pm25Point$Source <- rep("Point",4)
BaltNonPoint <- subset(BaltNEI, type == "NONPOINT")
pm25NonPoint <- data.frame(Emissions = with(BaltNonPoint, tapply(Emissions, year,
                                                           sum, na.rm=TRUE)),
                        Year = Year)
pm25NonPoint$Source <- rep("Nonpoint",4)
BaltOnRoad <- subset(BaltNEI, type == "ON-ROAD")
pm25OnRoad <- data.frame(Emissions = with(BaltOnRoad, tapply(Emissions, year,
                                                           sum, na.rm=TRUE)),
                        Year = Year)
pm25OnRoad$Source <- rep("On-Road",4)
BaltNonRoad <- subset(BaltNEI, type == "NON-ROAD")
pm25NonRoad <- data.frame(Emissions = with(BaltNonRoad, tapply(Emissions, year,
                                                           sum, na.rm=TRUE)),
                        Year = Year)
pm25NonRoad$Source <- rep("Non-Road",4)

# Stitch them together in a way that allows ggplot to plot multiple lines
totalBaltPM25 <- rbind(pm25Point,pm25NonPoint,pm25OnRoad,pm25NonRoad)


## Plot the total emissions by year for each source type
g <- ggplot(totalBaltPM25, aes(x=Year, y=Emissions, group=Source, col=Source)) +
  geom_point(size = 2) +
  geom_line(size = 1.1, linetype=3) + 
  labs(title = "Baltimore City PM25 Emissions Decrease Except Point Source",
       x = "",
       y = "Annual Baltimore City PM25 Emissions (tons)")  
print(g)

dev.copy(png,filename="Plot3.PNG")
dev.off ()

