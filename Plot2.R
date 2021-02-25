# Create an exploratory plot using the base system to show how  emissions  
# have changed from 1999–2008 in Baltimore City 

NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

## Calculate the sum of all emissions for each year
BaltNEI <- subset(NEI, fips == "24510")
totalBaltPM25 <- data.frame(pm25 = with(BaltNEI, tapply(Emissions, year, 
                                                sum, na.rm=TRUE)), 
                        year = c("1999", "2002", "2005", "2008"))

## Plot the total emissions by year
with(totalBaltPM25,{
  plot(year, pm25, pch=20,axes=FALSE,
       main = "Balimore City PM25 Emissions decrease 1999 to 2008",
       xlab="",
       ylab="Annual Baltimore City PM25 Emissions (tons)",
       cex = 2,
       col = "steelblue")
  lines(year, pm25, lty = 3, lwd = 2, col = "steelblue")
  ## Axes are added manually so the x-axis labels will line up with
  ## the data points
  axis(1, at = c(1999, 2002, 2005, 2008), 
       labels = c("1999", "2002", "2005", "2008"))
  axis(2,pretty(range(pm25)))
  box()
})

dev.copy(png,filename="Plot2.PNG")
dev.off ()

