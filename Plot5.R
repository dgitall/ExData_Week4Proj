# Create an exploratory plot to show how  emissions from motor vehicle 
# changed from 1999–2008 in Baltimore City 

library(ggplot2)


NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

BaltNEI <- subset(NEI, fips == "24510")

# Make a vector of all of the SCC's with 'Highway Vehicles' in their name
motorVehicleSCC <- SCC[grep("Highway Vehicles", SCC$SCC.Level.Two),]
# subset out only those sources from the full US dataset
motorVehicleBaltNEI <- subset(BaltNEI, BaltNEI$SCC %in% motorVehicleSCC$SCC)
totalmotorVehicleBaltPM25 <- data.frame(Emissions = with(motorVehicleBaltNEI, 
                                                         tapply(Emissions, year,
                                                                sum, na.rm=TRUE)),
                                        Year = c("1999", "2002", "2005", "2008"))

## Plot the total emissions by year for coal related sources
g <- ggplot(totalmotorVehicleBaltPM25, aes(x=Year, y=Emissions, group=1)) +
  geom_point(size = 2, color = "steelblue") +
  geom_line(size = 1.1, linetype=3, color = "steelblue") + 
  labs(title = "Baltimore City PM25 Emissions From Motor Vehicles Decrease Over Time",
       x = "",
       y = "PM25 Emissions (tons)")  
print(g)

dev.copy(png,filename="Plot5.PNG")
dev.off ()

