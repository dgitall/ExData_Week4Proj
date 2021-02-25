# Create an exploratory plot using the base system to show how total emissions  
# have changed from 1999–2008 in the US 

NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

## Calculate the sum of all emissions for each year
totalPM25 <- data.frame(pm25 = with(NEI, tapply(Emissions, year, 
                                         sum, na.rm=TRUE)), 
                        year = c("1999", "2002", "2005", "2008"))

## Plot the total emissions by year
with(totalPM25,{
  plot(year, pm25/1e+06, pch=20,axes=FALSE,
       main = "Total U.S. PM25 Emissions Decrease Over Time",
       xlab="",
       ylab="Annual U.S. PM25 Emissions (million tons)",
       cex = 2,
       col = "steelblue")
  lines(year, pm25/1e+06, lty = 3, lwd = 2, col = "steelblue")
  ## Axes are added manually so the x-axis labels will line up with
  ## the data points
  axis(1, at = c(1999, 2002, 2005, 2008), 
       labels = c("1999", "2002", "2005", "2008"))
  axis(2,pretty(range(pm25/1e+06)))
  box()
})

dev.copy(png,filename="Plot1.PNG")
dev.off ()

