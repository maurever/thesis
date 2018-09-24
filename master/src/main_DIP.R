libLoc = "~/lib"
dataLoc = "~/data"
outLoc = "~/R/output"
rLoc = "~/R_code"

# All functions used in script
source(paste(rLoc,"/functions.R", sep=""))

# All libraries used in script
source(paste(rLoc,"/libraries.R", sep=""))

# Read data from database export and select only data from Prague
# Prepare grid

name = "praha"
fromX = -758000
toX = -721500
fromY = -1060000
toY = -1033000

raster = 100
rasterData = prepareRasterGrid(raster)
rasterDataPraha = prepareRasterGridPart(raster, rasterData, name, fromX, toX, fromY, toY)

raster = 200
rasterData = prepareRasterGrid(raster)
rasterDataPraha = prepareRasterGridPart(raster, rasterData, name, fromX, toX, fromY, toY)

raster = 500
rasterData = prepareRasterGrid(raster)
rasterDataPraha = prepareRasterGridPart(raster, rasterData, name, fromX, toX, fromY, toY)

rm(rasterData, rasterDataPraha)

# Data merging
crimes = read.csv(paste(dataLoc, "pripady3.csv", sep ="/"))
#crimes = crimes[,c(1:25, 26,27,29,30,32,33,35,36,38,39,41,42)]
#colnames(crimes)[c(26:37)] = c("idx100", "x100", "idy100", "y100", "idx200", "x200", "idy200", "y200","idx500", "x500", "idy500", "y500")

crimesT = crimes[,c(6,7)]
crimesT$datozn = as.POSIXlt(crimesT$datozn)
crimesT$datod = as.POSIXlt(crimesT$datod)
crimesT$datOznOdDiffD = as.numeric(crimesT$datozn-crimesT$datod, units="days")
crimesT$datOznOdDiffH = as.numeric(crimesT$datozn-crimesT$datod, units="hours")
crimesT$datOznOdDiffMi = as.numeric(crimesT$datozn-crimesT$datod, units="mins")

invalidData = crimesT[crimesT$datOznOdDiffMi < 0,]
numID = nrow(invalidData)
numAll = nrow(crimesT)
numID/numAll * 100
nrow(crimesT[crimesT$datOznOdDiffMi > -10 & crimesT$datOznOdDiffMi < -1,])/numID * 100
rm(crimesT)

crimesTypes = read.csv(paste(dataLoc, "pripadytridy.csv", sep="/"))
#crimesCodes = read.csv(paste(dataLoc, "cistridy.csv", sep="/"))

crimesWithTypes = merge.data.frame(crimes, crimesTypes, by = "globalid", all = TRUE)
write.csv(crimesWithTypes, paste(dataLoc, "/pripady_s_tridou.csv", sep=""), row.names = FALSE)
rm(crimes)

#crimesWithTypesT = crimesWithTypes[crimesWithTypes$druhdelikt == "T", ]
#write.csv(crimesWithTypesT, paste(dataLoc, "/pripadyT.csv", sep=""), row.names = FALSE)

#crimesWithTypesP = crimesWithTypes[crimesWithTypes$druhdelikt == "P",]
#write.csv(crimesWithTypesP, paste(dataLoc, "/pripadyP.csv", sep=""), row.names = FALSE)

#rm(crimesCodes)
rm(crimesTypes)
rm(crimesWithTypes)

#crimesWithTypesT = read.csv(paste(dataLoc, "/pripadyT.csv", sep=""))
#crimesWithTypesP = read.csv(paste(dataLoc, "/pripadyP.csv", sep=""))

crimesWithTypes = read.csv(paste(dataLoc, "/pripady_s_tridou.csv", sep=""))

# Select types of crime - E.01, D.01, E.05 and PR040101 from Prague 
# (dataset crimesWithTypes contains duplicity due to merging by type - one crime has many types)
# E.01
crimesWithTypes_E01 = crimesWithTypes[crimesWithTypes$kod == "E.01", ]
crimesWithTypes_E01 = crimesWithTypes_E01[!is.na(crimesWithTypes_E01$kod),]
write.csv(crimesWithTypes_E01, paste(dataLoc, "/E01/pripady_E01.csv", sep=""), row.names = FALSE)

# crimesWithTypes_E01_praha = crimesWithTypes_E01[crimesWithTypes_E01$kraj == "Hlavní město Praha", ]
crimesWithTypes_E01_praha = crimesWithTypes_E01[(crimesWithTypes_E01$x100 > -758000 & crimesWithTypes_E01$x100 < -721500 &  crimesWithTypes_E01$y100 > -1060000 & crimesWithTypes_E01$y100 < -1033000), ]
write.csv(crimesWithTypes_E01_praha, paste(dataLoc, "/E01/pripady_E01_praha.csv", sep=""), row.names = FALSE)

rm(crimesWithTypes_E01)
rm(crimesWithTypes_E01_praha)

# D.01
crimesWithTypes_D01 = crimesWithTypes[crimesWithTypes$kod == "D.01", ]
crimesWithTypes_D01 = crimesWithTypes_D01[!is.na(crimesWithTypes_D01$kod),]
write.csv(crimesWithTypes_D01, paste(dataLoc, "/D01/pripady_D01.csv", sep=""), row.names = FALSE)

# crimesWithTypes_D01_praha = crimesWithTypes_D01[crimesWithTypes_D01$kraj == "Hlavní město Praha", ]
crimesWithTypes_D01_praha = crimesWithTypes_D01[(crimesWithTypes_D01$x100 > -758000 & crimesWithTypes_D01$x100 < -721500 &  crimesWithTypes_D01$y100 > -1060000 & crimesWithTypes_D01$y100 < -1033000), ]
write.csv(crimesWithTypes_D01_praha, paste(dataLoc, "/D01/pripady_D01_praha.csv", sep=""), row.names = FALSE)

rm(crimesWithTypes_D01)
rm(crimesWithTypes_D01_praha)

# E.05
crimesWithTypes_E05 = crimesWithTypes[crimesWithTypes$kod == "E.05", ]
crimesWithTypes_E05 = crimesWithTypes_E05[!is.na(crimesWithTypes_E05$kod),]
write.csv(crimesWithTypes_E05, paste(dataLoc, "/E05/pripady_E05.csv", sep=""), row.names = FALSE)

# crimesWithTypes_E05_praha = crimesWithTypes_E05[crimesWithTypes_E05$kraj == "Hlavní město Praha", ]
crimesWithTypes_E05_praha = crimesWithTypes_E05[(crimesWithTypes_E05$x100 > -758000 & crimesWithTypes_E05$x100 < -721500 &  crimesWithTypes_E05$y100 > -1060000 & crimesWithTypes_E05$y100 < -1033000), ]
write.csv(crimesWithTypes_E05_praha, paste(dataLoc, "/E05/pripady_E05_praha.csv", sep=""), row.names = FALSE)

rm(crimesWithTypes_E05)
rm(crimesWithTypes_E05_praha)

# PR040101
crimesWithTypes_PR040101 = crimesWithTypes[crimesWithTypes$kod == "PR040101", ]
crimesWithTypes_PR040101 = crimesWithTypes_PR040101[!is.na(crimesWithTypes_PR040101$kod),]
write.csv(crimesWithTypes_PR040101, paste(dataLoc, "/PR040101/pripady_PR040101.csv", sep=""), row.names = FALSE)

#crimesWithTypes_PR040101_praha = crimesWithTypes_PR040101[crimesWithTypes_PR040101$kraj == "Hlavní město Praha", ]
crimesWithTypes_PR040101_praha = crimesWithTypes_PR040101[(crimesWithTypes_PR040101$x100 > -758000 & crimesWithTypes_PR040101$x100 < -721500 &  crimesWithTypes_PR040101$y100 > -1060000 & crimesWithTypes_PR040101$y100 < -1033000), ]
write.csv(crimesWithTypes_PR040101_praha, paste(dataLoc, "/PR040101/pripady_PR040101_praha.csv", sep=""), row.names = FALSE)

rm(crimesWithTypes_PR040101)
rm(crimesWithTypes_PR040101_praha)
rm(crimesWithTypes)

# Create raster shapefile 
# 100 m
difference = 100
name = paste("raster",difference, "_praha", sep="")
raster_praha = read.csv(paste(dataLoc, "/rastr",difference,"_praha.csv", sep=""))

dd = makeRasterShapefile(raster_praha, difference, name)

# 200 m
difference = 200
name = paste("raster",difference, "_praha", sep="")
raster_praha = read.csv(paste(dataLoc, "/rastr",difference,"_praha.csv", sep=""))

dd = makeRasterShapefile(raster_praha, difference, name)

# 500 m
difference = 500
name = paste("raster",difference, "_praha", sep="")
raster_praha = read.csv(paste(dataLoc, "/rastr",difference,"_praha.csv", sep=""))

dd = makeRasterShapefile(raster_praha, difference, name)

rm(raster_praha, dd)

# Preprocessing by type part 1 

type = "E05"
types = c("D01", "E01", "E05","PR040101")

raster100 = read.csv(paste(dataLoc, "/rastr100.csv", sep = ""))
raster200 = read.csv(paste(dataLoc, "/rastr200.csv", sep = ""))
raster500 = read.csv(paste(dataLoc, "/rastr500.csv", sep = ""))

for(type in types){
  data = read.csv(paste(dataLoc, "/",type,"/pripady_",type,"_praha.csv", sep = ""))
  data$praha = 0
  data[data$kraj == "Hlavní město Praha","praha"] = 1
  data = data[,-3]
  
  # add rectangle id
  merge100 = merge(data, raster100, by.x = c("idx100", "idy100"), by.y = c("id_x", "id_y"), all.x = T, sort = FALSE)
  merge200 = merge(merge100, raster200, by.x = c("idx200", "idy200"), by.y = c("id_x", "id_y"), all.x = T, sort = FALSE)
  merge500 = merge(merge200, raster500, by.x = c("idx500", "idy500"), by.y = c("id_x", "id_y"), all.x = T, sort = FALSE)
  
  colnames(merge500)[c(29,32, 35)] = c("recId100", "recId200", "recId500")
  data = merge500[c(7:18, 25, 26, 29, 19, 20, 5, 6, 32, 21, 22, 3,4, 35, 23, 24, 1,2)]
  
  print(nrow(data[is.na(data$recId100),]))
  print(nrow(data[is.na(data$recId200),]))
  print(nrow(data[is.na(data$recId500),]))
  
  # separate date into minute, hour, day, weekday, week, month, year columns 
  datetimeColumns = c("datozn", "datod", "datdo")
  data = separateDate(data, datetimeColumns)
  
  min(data$datodY)
  plotHistogram(data, data$datodY, "Year", "Count", c(0,13000))
  
  # select relevant date range
  from = as.POSIXlt("2013-01-01")
  data = data[data$datod > from,]
  maxDate = max(data$datdo)
  
  # get different between datod and dateto
  data$datDoOdDiffMi = as.numeric(data$datdo-data$datod, units="mins")
  data$datDoOdDiffH = as.numeric(data$datdo-data$datod, units="hours")
  data$datDoOdDiffD = as.numeric(data$datdo-data$datod, units="days")
  data$datDoOdDiffDf = floor(data$datDoOdDiffD)
  
  # get different between datod and dateozn
  data$datOznOdDiffMi = as.numeric(data$datozn-data$datod, units="mins")
  data$datOznOdDiffH = as.numeric(data$datozn-data$datod, units="hours")
  data$datOznOdDiffD = as.numeric(data$datozn-data$datod, units="days")
  data$datOznOdDiffDf = floor(data$datOznOdDiffD)
  
  # ASK!
  # invalid data with dateozn < dateod, remove?
  completData = nrow(data)
  removedDataNegative = nrow(data[data$datOznOdDiffDf < 0, ])
  removedDataPositive = nrow(data[data$datOznOdDiffDf > 7, ])
  (removedDataNegative+removedDataPositive)/completData * 100
  
  #data = data[data$datOznOdDiffDf < 8, ]
  data = data[data$datOznOdDiffDf > -1, ]
  
  # select data with interval less than 5
  removedData = nrow(data[data$datDoOdDiffDf > 7, ])
  removedData/completData * 100
  data = data[data$datDoOdDiffDf < 8, ]
  
  # get hour category (class 1 = <0,5), class 2 = <5, 9), ... )
  from = c(0, 5, 9, 12, 18)
  to = c(5, 9, 12, 18, 24)
  data = setCategory(data, from, to, c("datoznH", "datodH", "datdoH"))
  
  # get season category (class 1 = autumn, class 2 = winter, class 3 = spring, class 4 = Summer)
  data = setSeason(data, c("datoznMo", "datodMo", "datdoMo"))
  
  # one hot encoding
  data = dummy.data.frame(data, names=c("stavobj"), sep="_")
  data = dummy.data.frame(data, names=c("datDoOdDiffDf"), sep="_")
  data = dummy.data.frame(data, names=c("datodHCat"), sep="_")
  
  write.csv(data, paste(dataLoc, "/",type,"/pripady","_",type,"_praha_pre1.csv", sep=""), row.names = FALSE)
}

rm(merge100, merge200, merge500, raster100, raster200, raster500)

# basic analysis

type = "E05"
data = read.csv(paste(dataLoc, "/",type,"/pripady_",type,"_praha_pre2_200.csv", sep=""))

summary(data)

group <- function(data, column){
  groups = aggregate(data[,column], by=list(data[,column]), FUN=length)
  colnames(groups) = c("Group", "N")
  groups
}

plotHistogram<-function(data, column, xaxis, yaxis, ylim, title = "")
{
  g = ggplot(data=data,aes(column)) + 
    geom_bar(col="white",
             fill="black",
             alpha = .5) + 
    labs(x=xaxis, y=yaxis) +
    geom_text(stat='count', aes(label=..count..), vjust=-1) +
    scale_x_discrete(limits=(min(column):max(column))) +
    ylim(ylim) +
    ggtitle(title)
  g
}

p1 = plotHistogram(data, data$datodY, "Year", "Count", c(0,14000), "")
p2 = plotHistogram(data, data$datodMo, "Month", "Count", c(0,4200), "")
p3 = plotHistogram(data, data$datodMoCat, "Month category", "Count", c(0,13000), "")
p4 = plotHistogram(data, data$datodD, "Day", "Count", c(0,1500), "")

plotHistogram(data, data$datodWD, "Weekday", "Count", c(0,7000), "")

multiplot(p1, p3, cols=1)
multiplot(p2, p4, cols=1)

groupRectangle = group(data, "recId200")

from = c(0, 200, 400, 600, 800, 1000, 1200, 1400, 1600, 1800)
to = c(200, 400, 600, 800, 1000, 1200, 1400, 1600, 1800, 2000)
groupRectangleCat = setCategory(groupRectangle, from, to, c("N"))

p7 = plotHistogram(groupRectangleCat, groupRectangleCat$NCat, "Crime count in rectangle", "Count", c(0,100), "")
p8 = plotHistogram(data, data$crimecount, "Number crimes a day", "Count", c(0,38000), "")

p8
multiplot(p7, p8, cols=1)

data$datod = as.POSIXlt(data$datod)
days= max(data$datod) - min(data$datod)


hist(data$datodY)
hist(data$datodMo)
hist(data$datodW)
hist(data$datodD)
hist(data$datodWD)
hist(data$datodH)
hist(data$datodMi)

hist(data$datdoY)
hist(data$datdoMo)
hist(data$datdoW)
hist(data$datdoD)
hist(data$datdoWD)
hist(data$datdoH)
hist(data$datdoMi)

hist(data$datodHCat)
hist(data$datodMoCat)

hist(data$datdoHCat)
hist(data$datdoMoCat)

hist(data$datDoOdDiffDf, freq=FALSE, ylim = c(0, 1), xlim=c(0,7), breaks=c(0,1,2,3,4,5,6,7))
hist(data$datOznOdDiffDf, freq=FALSE, ylim = c(0, 1), xlim=c(-1,20), breaks=c(min(data$datOznOdDiffDf),0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20, max(data$datOznOdDiffDf)))

rm(data)

# Correct duplicities from data (bug where one square has more than one 'kraj')

correctData<-function(data){
  dataUnique = unique(data[,c("recId200","praha")])
  duplicatedIDs = dataUnique[duplicated(dataUnique$recId200),"recId200"]
  
  for(i in duplicatedIDs){
    data[data$recId200 == i,"praha"] = 1
  }
  data
}

# Preprocessing by type part 2
# group data by day
types = c("E05")
rasters = c(200)

for(type in types){
  for(raster in rasters){
    data = read.csv(paste(dataLoc, "/",type,"/pripady_",type,"_praha_pre1.csv", sep=""))
    data = correctData(data)
    groupedData = groupData(data, raster)
    write.csv(groupedData, paste(dataLoc, "/",type,"/pripady", "_",type,"_praha_pre2_",raster,".csv", sep=""), row.names = FALSE)
  }
}

rm(data, groupedData)

# generate zero crime days
types = c("E05")
rasters = c(200)

dateFrom = "2013-06-16"
dateTo = "2017-03-08"

for(type in types){
  for(raster in rasters){
    print(paste(type, raster))
    data = read.csv(paste(dataLoc, "/",type,"/pripady","_",type,"_praha_pre2_", raster, ".csv", sep=""))
    dataIdCol = paste("recId", raster, sep="")
    completedData = getCompletedDaysDataFromTo(data, raster, dateFrom, dateTo)
    write.csv(completedData, paste(dataLoc, "/",type,"/completed_data_", raster, "_", type, "_",dateFrom,"_", dateTo, ".csv", sep=""), row.names = FALSE)
  }
}

rm(data, completedData)

# generate timeseries
dateFrom = "2013-06-16"
dateTo = "2017-03-08"

types = c("E05")
rasters = c(200)

for(type in types){
  for(raster in rasters){
    print(paste(type, raster))
    data = read.csv(paste(dataLoc, "/",type,"/completed_data_", raster, "_", type, "_",dateFrom,"_", dateTo, ".csv", sep=""))
    timeseries = getTimeSeriesData(data, raster, 100)
    write.csv(timeseries, paste(dataLoc, "/",type,"/timeseries_", raster, "_", type, "_",dateFrom,"_", dateTo, ".csv", sep=""), row.names = FALSE)
  }
}

rm(data, timeseries)

# split timeseries
types = c("E05")
rasters = c(200)

dateFrom = "2013-06-16"
dateTo = "2017-03-08"

interval = 21
modulo = 100

for(type in types){
  for(raster in rasters){
    print(paste(type, raster))
    data = read.csv(paste(dataLoc, "/",type,"/timeseries_", raster, "_", type, "_",dateFrom,"_", dateTo, ".csv", sep=""))
    tmData = splitTimeseriesData(data, interval, dateFrom, dateTo, 50)
    write.csv(tmData, paste(dataLoc, "/",type,"/tmdata_",interval, "_", raster, "_", type, "_",dateFrom,"_", dateTo, ".csv", sep=""), row.names = FALSE)
  }
}
rm(data, tmData)

# complete data into dataset

types = c("E05")
rasters = c(200)

dateFrom = "2013-06-16"
dateTo = "2017-03-08"

interval = 21

for(type in types){
  for(raster in rasters){
    print(paste(type, raster))
    completedData = read.csv(paste(dataLoc, "/",type,"/completed_data_", raster, "_", type, "_",dateFrom,"_", dateTo, ".csv", sep=""))
    completedData$date = as.Date(completedData$date)
    
    # save fixed data
    completedDataWithoutObj = completedData[,c(1:13, 20:32, 38)]
    
    # save non fixed data
    completedDataWithObj =  completedData[,c(1, 7, 14:19, 33:37)]
    rm(completedData)
    
    tmData = read.csv(paste(dataLoc, "/",type,"/tmdata_",interval, "_", raster, "_", type, "_",dateFrom,"_", dateTo, ".csv", sep=""))
    tmData$date = as.Date(tmData$date)
    
    tmDataAll = merge(tmData[,c("id", "date", paste("d", 1:interval, sep=""))], completedDataWithoutObj, by.x = c("id","date"), by.y = c(paste("recId", raster,sep = ""), "date"), all.x = TRUE)
    rm(completedDataWithoutObj, tmData)
    
    completedDataWithObj$date = completedDataWithObj$date + 1
    tmDataAll = merge(tmDataAll, completedDataWithObj, by.x = c("id","date"), by.y = c(paste("recId", raster,sep = ""), "date"), all.x = TRUE)
    
    write.csv(tmDataAll, paste(dataLoc, "/",type,"/tmdata_complet_",interval, "_", raster, "_", type, "_",dateFrom,"_", dateTo, ".csv", sep=""), row.names = FALSE)
  }
}
rm(tmDataAll, completedDataWithObj)

# Select sub Prague
type = "E05"
raster = 200
dateFrom = "2013-06-16"
dateTo = "2017-03-08"

interval = 21

tmDataAll = read.csv(paste(dataLoc, "/",type,"/tmdata_complet_",interval, "_", raster, "_", type, "_",dateFrom,"_", dateTo, ".csv", sep=""))

View(tmDataAll[tmDataAll$id == 2877148,c(1:23,48, 53:59)])
length(unique(tmDataAll$id))

tmDataAll$date = as.POSIXlt(tmDataAll$date)
min = min(tmDataAll$date)
max = max(tmDataAll$date)
max - min

x_min_a = -744800
x_max_a = -734800
y_min_a = -1051600
y_max_a = -1041600

x_min_s = -743800
x_max_s = -735800
y_min_s = -1050600
y_max_s = -1042600

(x_max_s - x_min_s)/200
(x_max_a - x_min_a)/200
(y_max_s - y_min_s)/200
(y_max_a - y_min_a)/200

tmDataSelect = tmDataAll[tmDataAll$x200 >= x_min_a & tmDataAll$x200 <= x_max_a & tmDataAll$y200 >= y_min_a & tmDataAll$y200 <= y_max_a,]
tmDataSelect$praha = 0
tmDataSelect[tmDataSelect$x200 > x_min_s & tmDataSelect$x200 < x_max_s & tmDataSelect$y200 > y_min_s & tmDataSelect$y200 < y_max_s, "praha"] = 1
mean(tmDataSelect$praha)
tmDataSelect = tmDataSelect[order(tmDataSelect$date), ]
write.csv(tmDataSelect, paste(dataLoc, "/",type,"/tmdata_complet_",interval, "_", raster, "_", type, "_",dateFrom,"_", dateTo, "_s_select.csv", sep=""), row.names = FALSE)

timeseries = read.csv(paste(dataLoc, "/",type,"/timeseries_", raster, "_", type, "_",dateFrom,"_", dateTo, ".csv", sep=""), check.names=FALSE)
timeseriesSelect = timeseries[timeseries$x >= x_min_a & timeseries$x <= x_max_a & timeseries$y >= y_min_a & timeseries$y <= y_max_a,]
timeseriesSelect$praha = 0
timeseriesSelect[timeseriesSelect$x >= x_min_s & timeseriesSelect$x <= x_max_s & timeseriesSelect$y >= y_min_s & timeseriesSelect$y <= y_max_s,"praha"] = 1
mean(timeseriesSelect$praha)
write.csv(timeseriesSelect, paste(dataLoc, "/",type,"/timeseries_", raster, "_", type, "_",dateFrom,"_", dateTo, "_select.csv", sep=""), row.names = FALSE)

ts = timeseries[order(timeseries$id, timeseries$praha), ]
ts[duplicated(ts$id),"id"]

plot(timeseries$x, timeseries$y)
plot(timeseriesSelect$x, timeseriesSelect$y, col=c("red","blue")[timeseriesSelect$praha])
plot(timeseries$x, timeseries$y, col=c("red","blue")[timeseries$praha])

qplot(x, y, colour = praha, data = timeseries, size = I(0.5))

View(data[data$x200 == -746800 & data$y200 == -1057600,])

# generate historic shapefile

types = c("D01","E01","E05","PR040101")
rasters = c(100, 200, 500)

for(type in types){
  for(raster in rasters){
    data = read.csv(paste(dataLoc, "/",type,"/pripady", "_",type,"_praha_pre2_", raster, ".csv", sep=""))
    ddData = read.csv(paste(outLoc, "/gis/",type,"/point_table_", raster, ".csv", sep=""))
    
    data$Idu = c(1:nrow(data))
    ddTable = merge(ddData, data, by.x = "Id", by.y = colnames(data)[1], all.x = TRUE, sort = FALSE)
    ddTable = ddTable[!is.na(ddTable$Idu), c("Idu", "X", "Y")]
    
    ddTable = sortSquarePoints(ddTable)
    
    ddShapefile <- convert.to.shapefile(ddTable, data, "Idu", 5)
    write.shapefile(ddShapefile, paste(outLoc, "/gis/history_",type,"_", raster, sep=""), arcgis=F)
  }
}

rm(data, ddData, ddTable, ddShapefile)


