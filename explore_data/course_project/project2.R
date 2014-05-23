## Coursera Data Science
## Exploring Data
## Project 2

setwd("/home/tom/scripts/gnuR/coursera/explore_data/project")
if(!file.exists('data')){
    dir.create('data')
}

# file_url <- 
#     "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
# download.file(file_url, destfile = "./data/Project2.zip", method="curl")
# unzip("./data/Project2.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot 1
totals <- tapply(NEI$Emissions, NEI$year, sum)
title <- expression('PM'[25])
par(mar=c(4,5,3,2))
barplot(totals, main=expression("PM"[25] * " Totals in the USA"), xlab="Year", 
        ylab=expression("PM"[25] * " Emissions [tons]"), 
        axis.lty=1, lwd=2, col="red3", space=0, cex.main=1.5, 
        cex.lab=1.1, cex.axis=1.1, cex.sub=1.1)

# Plot 2
baltimore <- NEI[NEI$fips == "24510", ]
totals.baltimore <- tapply(baltimore$Emissions, baltimore$year, sum)
par(mar=c(4,5,3,2))
barplot(totals.baltimore, main=expression("PM"[25] * " Totals in Baltimore"),  
        xlab="Year", ylab=expression("PM"[25] * " Emissions [tons]"), 
        axis.lty=1, lwd=2, col="red3", space=0, cex.main=1.5, 
        cex.lab=1.1, cex.axis=1.1, cex.sub=1.1)

# Plot 3
library(ggplot2)
library(reshape2)
baltimore.melt <- melt(baltimore, id=c("year", "type"), measure.vars="Emissions")
baltimore.summary <- dcast(baltimore.melt, year ~ type, sum)
baltimore.summary.melt <- melt(baltimore.summary, id="year", 
                               measure.vars=names(baltimore.summary)[2:5])
names(baltimore.summary.melt)[2:3] <- c("type", "Emissions")

qplot(year, Emissions, data = baltimore.summary.melt, color=type, geom="line",
      main=expression("PM"[25] * " Totals in Baltimore"), xlab="Year", 
      ylab=expression("PM"[25] * " Emissions [tons]"))

# Plot 4
indices.coal <- union(grep("Coal", SCC[ , 3]), 
                      union(grep("Coal", SCC[ , 4]),
                      union(grep("Coal", SCC[ , 5]), 
                      union(grep("Coal", SCC[ , 6]),
                      union(grep("Coal", SCC[ , 7]), 
                            grep("Coal", SCC[ , 8]))))))
indices.comb <- union(grep("Comb", SCC[ , 3]), 
                      union(grep("Comb", SCC[ , 4]),
                      union(grep("Comb", SCC[ , 5]), 
                      union(grep("Comb", SCC[ , 6]),
                      union(grep("Comb", SCC[ , 7]), 
                      grep("Comb", SCC[ , 8]))))))
indices.coal.comb <- intersect(indices.coal, indices.comb)

coal.comb <- NEI[NEI$SCC %in% SCC$SCC[indices.coal.comb], ]
coal.comb.totals <- tapply(coal.comb$Emissions, coal.comb$year, sum)
coal <- data.frame(as.numeric(names(coal.comb.totals)), coal.comb.totals)
names(coal) <- c("Year", "Coal.Emissions")

g <- ggplot(data=coal, aes(x=Year, y=Coal.Emissions, ymin=0, ymax=10000))
g <- g + geom_point(size=4, color="red3") + 
    labs(title=expression("PM"[25] * " Totals from Coal Combustion")) +
    labs(x="Year") + labs(y=expression("PM"[25] * " Emissions [tons]"))
print(g)

# Plot 5
indices.motor <- union(grep("Motor", SCC[ , 3]), 
                      union(grep("Motor", SCC[ , 4]),
                      union(grep("Motor", SCC[ , 5]), 
                      union(grep("Motor", SCC[ , 6]),
                      union(grep("Motor", SCC[ , 7]), 
                      grep("Motor", SCC[ , 8]))))))
indices.vehicle <- union(grep("Veh", SCC[ , 3]), 
                      union(grep("Veh", SCC[ , 4]),
                      union(grep("Veh", SCC[ , 5]), 
                      union(grep("Veh", SCC[ , 6]),
                      union(grep("Veh", SCC[ , 7]), 
                      grep("Veh", SCC[ , 8]))))))
indices.car <- union(grep("Car", SCC[ , 3]), 
                         union(grep("Car", SCC[ , 4]),
                         union(grep("Car", SCC[ , 5]), 
                         union(grep("Car", SCC[ , 6]),
                         union(grep("Car", SCC[ , 7]), 
                         grep("Car", SCC[ , 8]))))))
indices.truck <- union(grep("Truck", SCC[ , 3]), 
                     union(grep("Truck", SCC[ , 4]),
                     union(grep("Truck", SCC[ , 5]), 
                     union(grep("Truck", SCC[ , 6]),
                     union(grep("Truck", SCC[ , 7]), 
                     grep("Truck", SCC[ , 8]))))))
indices.motor.vehicles <- union(indices.motor,  
                                union(indices.vehicle,
                                union(indices.car,
                                      indices.truck)))

motor.vehicles <- NEI[NEI$SCC %in% SCC$SCC[indices.motor.vehicles], ]
baltimore <- motor.vehicles[motor.vehicles$fips == "24510", ]
baltimore.totals <- tapply(baltimore$Emissions, baltimore$year, sum)
baltimore <- data.frame(as.numeric(names(baltimore.totals)), 
                        baltimore.totals)
names(baltimore) <- c("Year", "Emissions")
title.string <- expression("PM"[25]*" Totals from Motor Vehicles in Baltimore")

g <- ggplot(data=baltimore, aes(x=Year, y=Emissions, ymin=0, ymax=150))
g <- g + geom_point(size=4, color="red3") + 
    labs(title=title.string) + labs(x="Year") +
    labs(y=expression("PM"[25] * " Emissions [tons]"))
print(g)


# Plot 6
indices.motor <- union(grep("Motor", SCC[ , 3]), 
                       union(grep("Motor", SCC[ , 4]),
                       union(grep("Motor", SCC[ , 5]), 
                       union(grep("Motor", SCC[ , 6]),
                       union(grep("Motor", SCC[ , 7]), 
                       grep("Motor", SCC[ , 8]))))))
indices.vehicle <- union(grep("Veh", SCC[ , 3]), 
                       union(grep("Veh", SCC[ , 4]),
                       union(grep("Veh", SCC[ , 5]), 
                       union(grep("Veh", SCC[ , 6]),
                       union(grep("Veh", SCC[ , 7]), 
                       grep("Veh", SCC[ , 8]))))))
indices.car <- union(grep("Car", SCC[ , 3]), 
                       union(grep("Car", SCC[ , 4]),
                       union(grep("Car", SCC[ , 5]), 
                       union(grep("Car", SCC[ , 6]),
                       union(grep("Car", SCC[ , 7]), 
                       grep("Car", SCC[ , 8]))))))
indices.truck <- union(grep("Truck", SCC[ , 3]), 
                       union(grep("Truck", SCC[ , 4]),
                       union(grep("Truck", SCC[ , 5]), 
                       union(grep("Truck", SCC[ , 6]),
                       union(grep("Truck", SCC[ , 7]), 
                       grep("Truck", SCC[ , 8]))))))
indices.motor.vehicles <- union(indices.motor,  
                                union(indices.vehicle,
                                union(indices.car,
                                      indices.truck)))

motor.vehicles <- NEI[NEI$SCC %in% SCC$SCC[indices.motor.vehicles], ]
baltimore <- motor.vehicles[motor.vehicles$fips == "24510", ]
baltimore.totals <- tapply(baltimore$Emissions, baltimore$year, sum)
baltimore <- data.frame(as.numeric(names(baltimore.totals)), 
                        baltimore.totals)
names(baltimore) <- c("Year", "Emissions")

los.angeles <- motor.vehicles[motor.vehicles$fips == "06037", ]
los.angeles.totals <- tapply(los.angeles$Emissions, 
                             los.angeles$year, sum)
los.angeles <- data.frame(as.numeric(names(los.angeles.totals)), 
                          los.angeles.totals)
names(los.angeles) <- c("Year", "Emissions")

totals <- data.frame(rbind(baltimore, los.angeles))
totals <- cbind(totals, c(rep("Baltimore", 4), rep("Los Angeles", 4)))
names(totals) <- c("Year", "Emissions", "City")

# Approximate population from Google
los.angeles.pop = c(3634000, 3769000, 3795000, 3802000)
baltimore.pop = c(657441, 642246, 640064, 638091)

totals$Emissions.per.cap <- totals$Emissions / 
    c(baltimore.pop, los.angeles.pop)

title.string <- expression("PM"[25] * " per Capita from Motor Vehicles in"
                           * " Baltimore and Los Angeles")
g <- ggplot() +
    geom_point(data=totals, size=4, 
               aes(x=Year, y=Emissions.per.cap, color=City)) + 
    scale_colour_manual(values=c("Baltimore"="red3", "Los Angeles"="blue4")) +
    labs(title=title.string) + labs(x="Year") +
    labs(y=expression("PM"[25] * " Emissions per Capita [tons/person]"))
print(g)

## Clearly, Baltimore has seen greater changes over time, since Los Angeles
## has ended where it started.
