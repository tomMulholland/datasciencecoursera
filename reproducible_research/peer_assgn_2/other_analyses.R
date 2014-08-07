#Extra graphs and analyses
prop.dmg.year <- aggregate(NOAA.clean$Property.Damage, 
                           by=list(NOAA.clean$Event, NOAA.clean$Year), 
                           FUN=sum)
names(prop.dmg.year) <- c("Event", "Year", "Property.Damage")
crop.dmg.year <- aggregate(NOAA.clean$Crop.Damage, 
                           by=list(NOAA.clean$Event, NOAA.clean$Year), 
                           FUN=sum)
names(crop.dmg.year) <- c("Event", "Year", "Crop.Damage")
pie(hist.totals$Total.Damage, labels=hist.totals$Event, main="Total Damage (in $Millions)", col=rainbow(19))

qplot(Year, Property.Damage, data=prop.dmg.year, color=Event, geom="line", ylab="Property Damage (in Million USD)")
qplot(Year, Crop.Damage, data=crop.dmg.year, color=Event, geom="line", ylab="Crop Damage (in Million USD)")



total.deaths <- aggregate(NOAA.clean$Fatalities, 
                          by=list(NOAA.clean$Event, NOAA.clean$Year), 
                          FUN=sum)
names(total.deaths) <- c("Event", "Year", "Total.Deaths")
qplot(Year, Total.Deaths, data=total.deaths, color=Event, geom="line", 
      ylab="Total Deaths", main="Total Deaths Related to Weather")

The top 10 largest contributors are shown below.
```{r}
other <- sum(casualties.totals$Total.Casualties[11:dim(casualties.totals)[1]])
top.casualties<- data.frame(c(casualties.totals$Total.Casualties[1:10], other),
                            row.names=c(as.character(casualties.totals$Event[1:10]), 
                                        "All Other"))
names(top.casualties) <- "Casualties"
pie(top.casualties$Casualties, labels=row.names(top.casualties), 
    main="Total Casualties", col=rainbow(11))

```