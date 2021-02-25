# Create an exploratory plot to show how  emissions from motor vehicle 
# compare between Baltimore City and Los Angeles County over 1999-2008

library(ggplot2)


NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

BaltNEI <- subset(NEI, fips == "24510")
LANEI <- subset(NEI, fips == "06037")

# Make a vector of all of the SCC's with 'Highway Vehicles' in their name
motorVehicleSCC <- SCC[grep("Highway Vehicles", SCC$SCC.Level.Two),]

# subset out only those sources from the full US dataset for Baltimore City
# and for Los Angeles County
motorVehicleBaltNEI <- subset(BaltNEI, BaltNEI$SCC %in% motorVehicleSCC$SCC)
totalmotorVehicleBaltPM25 <- data.frame(Emissions = with(motorVehicleBaltNEI, 
                                                         tapply(Emissions, year,
                                                                sum, na.rm=TRUE)), 
                                        Year = c("1999", "2002", "2005", "2008"),
                                        Location = rep("Baltimore City", 4))
motorVehicleLANEI <- subset(LANEI, LANEI$SCC %in% motorVehicleSCC$SCC)
totalmotorVehicleLAPM25 <- data.frame(Emissions = with(motorVehicleLANEI, 
                                                       tapply(Emissions, year, 
                                                              sum, na.rm=TRUE)), 
                                        Year = c("1999", "2002", "2005", "2008"),
                                        Location = rep("Los Angeles County", 4))
totalmotorVehicleComboPM25 <- rbind(totalmotorVehicleBaltPM25, 
                                    totalmotorVehicleLAPM25)
## Plot the total emissions by year for motor vehicle related sources
g <- ggplot(totalmotorVehicleComboPM25, aes(x=Year, y=Emissions,
                                            group=Location, col = Location)) +
  geom_point(size = 2) +
  geom_line(size = 1.1, linetype=3) + 
  labs(title = "PM25 Emissions From Motor Vehicles",
       x = "",
       y = "PM25 Emissions (tons)")  
print(g)

dev.copy(png,filename="Plot6.PNG")
dev.off ()

