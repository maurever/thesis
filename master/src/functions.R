prepareRasterGrid<-function(raster)
{
  rasterx = read.csv(paste(dataLoc, "/rastr",raster,"x.csv", sep =""), sep = ",", header = TRUE)
  rastery = read.csv(paste(dataLoc, "/rastr",raster,"y.csv", sep =""), sep = ",", header = TRUE)
  raster_part = preprocessRasterFiles(rasterx, rastery)
  raster_part$id = seq(from=1, to=nrow(raster_part))
  write.csv(raster_part, paste(dataLoc, "/rastr",raster,".csv", sep=""), row.names = FALSE)
  raster_part
}

prepareRasterGridPart<-function(raster, data, name, fromX, toX, fromY, toY)
{
  raster_part = data[(data$x > fromX & data$x < toX & data$y > fromY & data$y < toY),]
  write.csv(raster_part, paste(dataLoc, "/rastr",raster,"_",name,".csv", sep=""), row.names = FALSE)
  raster_part
}

preprocessRasterFiles<-function(rasterX, rasterY)
{
  raster = merge(rasterX, rasterY, by=NULL)
  colnames(raster) = c("id_x", "x","x2", "id_y", "y", "y2")
  rasterPart = raster[,c("id_x","x","id_y", "y")]
  rasterPart
}

makeRasterShapefile <- function(raster, difference, name)
{
  minX = min(raster$x)
  minY = min(raster$y)
  maxX = max(raster$x)+difference
  maxY = max(raster$y)+difference
  
  ddTable <- data.frame(Id=numeric(), X1=numeric(), X2=numeric(),  Y1=numeric(), Y2=numeric(), stringsAsFactors = FALSE)
  rows = (nrow(raster))
  ddTable[1:rows, 1] = raster$id
  ddTable$X1 = raster$x
  ddTable$X2 = raster$x + difference
  ddTable$Y1 = raster$y
  ddTable$Y2 = raster$y + difference
  
  dd = data.frame(Id=numeric(), X=numeric(), Y=numeric())
  ddTmp = data.frame(Id=numeric(), X=numeric(), Y=numeric())
  counter = 1
  modulo = 1000
  for (i in 1:nrow(ddTable)) {
    if(i%%modulo == 0) {
      dd = rbind(dd, ddTmp)
      ddTmp = dd[0,]
      counter = 1
      print(i)
    }
    end = counter+4
    ddTmp[counter:end,1] = ddTable[i,1]
    ddTmp[counter:end,2] <- c(ddTable[i,2], ddTable[i,3], ddTable[i,3], ddTable[i,2], ddTable[i,2])
    ddTmp[counter:end,3] <- c(ddTable[i,4], ddTable[i,4], ddTable[i,5], ddTable[i,5], ddTable[i,4])
    counter = counter + 5
  }
  dd = rbind(dd, ddTmp)
  write.csv(dd, paste(outLoc, "/gis/point_table_", difference, ".csv", sep=""), row.names = FALSE)
  ddShapefile <- convert.to.shapefile(dd, ddTable, "Id", 5)
  write.shapefile(ddShapefile, paste(outLoc, "/gis/", name, sep=""), arcgis=F)
  ddTable
}

separateDate<-function(dataset, columns)
{
  for(column in columns){
    i = match(column,names(dataset))
    dataset[, c(i)] = as.data.frame(as.POSIXlt(dataset[, i]))[,1]
    dataset[, paste(column, "Y", sep="")] = as.numeric(format(dataset[,i], "%Y"))
    dataset[, paste(column, "Mo", sep="")] = as.numeric(format(dataset[,i], "%m"))
    dataset[, paste(column, "W", sep="")] = as.numeric(format(dataset[,i], "%W"))
    dataset[, paste(column, "D", sep="")] = as.numeric(format(dataset[,i], "%d"))
    dataset[, paste(column, "WD", sep="")] = as.numeric(format(dataset[,i], "%w"))
    dataset[, paste(column, "H", sep="")] = as.numeric(format(dataset[,i], "%H"))
    dataset[, paste(column, "Mi", sep="")] = as.numeric(format(dataset[,i], "%M"))
  }
  dataset
}

setCategory <- function(data, from, to, colNames)
{
  for(colName in colNames){
    newColName = paste(colName, "Cat", sep="")
    data[,newColName] = 0
    l = length(from)
    for (i in 1:l) {
      data[data[,colName] >= from[i] & data[,colName] < to[i], newColName] = i
    }
  }
  data
}

setSeason <- function(data, colNames)
{
  for(colName in colNames){
    newColName = paste(colName, "Cat", sep="")
    data[,newColName] = 0
    data[data[,colName] > 8 & data[,colName] < 12, newColName] = 1
    data[data[,colName] == 12 | (data[,colName] >= 1 & data[,colName] < 3), newColName] = 2
    data[data[,colName] > 2 & data[,colName] < 7, newColName] = 3
    data[data[,colName] > 6 & data[,colName] < 9, newColName] = 4
  }
  data
}

groupData<-function(data, raster)
{
  groupedData = sqldf(paste("SELECT recId",raster,", idx",raster,", x",raster,", idy",raster,", y",raster,", praha, datod, datodY, datodMo, datodW, datodD, datodWD,
                            sum(stavobj_A) as stavobj_A, sum(stavobj_B) as stavobj_B, sum(stavobj_C) as stavobj_C, sum(stavobj_D) as stavobj_D,
                            sum(stavobj_F) as stavobj_F, sum(stavobj_G) as stavobj_G, lokalitarelevance, vzdbcs, vzdpostabanka, vzdprodejna, vzdrestaurace,  
                            sum(datDoOdDiffDf_0) as datDoOdDiffDf_0, sum(datDoOdDiffDf_1) as datDoOdDiffDf_1, sum(datDoOdDiffDf_2)  as datDoOdDiffDf_2, 
                            sum(datDoOdDiffDf_3) as datDoOdDiffDf_3, sum(datDoOdDiffDf_4) as datDoOdDiffDf_4, sum(datDoOdDiffDf_5)  as datDoOdDiffDf_5, 
                            sum(datDoOdDiffDf_6) as datDoOdDiffDf_6, sum(datDoOdDiffDf_7) as datDoOdDiffDf_7, sum(datodHCat_1) as datodHCat_1, 
                            sum(datodHCat_2) as datodHCat_2, sum(datodHCat_3) as datodHCat_3, sum(datodHCat_4) as datodHCat_4, sum(datodHCat_5) as datodHCat_5,
                            datodMoCat, count(*) as crimecount 
                            FROM data 
                            GROUP BY recId",raster,", datodY, datodMo, datodW, datodD 
                            ORDER BY recId",raster,", datodY, datodMo, datodW, datodD", sep=""));
  groupedData
}

sortSquarePoints<-function(squarePointsData)
{
  data = squarePointsData[0,]
  ids = unique(squarePointsData$Idu)
  from = 1
  to = 5
  for(id in ids){
    data[from:to, ] = sortSimpleSquarePoints(squarePointsData[squarePointsData$Id == id,])
    from = to + 1
    to = to + 5
  }
  data
}

sortSimpleSquarePoints<-function(simpleSquarePointsData)
{
  data = simpleSquarePointsData
  data[c(1,4,5), 2] = min(simpleSquarePointsData[,2])
  data[c(2,3), 2] = max(simpleSquarePointsData[,2])
  data[c(1,2,5), 3] = min(simpleSquarePointsData[,3])
  data[c(3,4), 3] = max(simpleSquarePointsData[,3])
  data
}

setMissingValues<-function(data, columns, set)
{
  for(column in columns){
    data[is.na(data[, column]), column] = set
  }
  data
}

getCompletedDaysDataFromTo<-function(data, raster, dateFrom, dateTo)
{
  dataIdCol = colnames(data)[1]
  allRec = unique(data[, c(dataIdCol, "praha", paste("idx",raster,sep=""),paste("x",raster,sep=""),paste("idy",raster,sep=""),paste("y",raster,sep=""))])
  days <- seq(from=as.Date(dateFrom), to=as.Date(dateTo), by='days')
  dayData = merge(allRec, days, by=NULL)
  colnames(dayData)[7] = "date"
  dayData$Y = as.integer(format(dayData$date, format = "%Y"))
  dayData$Mo = as.integer(format(dayData$date, format = "%m"))
  dayData$W = as.integer(format(dayData$date, format = "%W"))
  dayData$D = as.integer(format(dayData$date, format = "%d"))
  dayData$WD = as.integer(format(dayData$date, format = "%u"))
  dayData = setSeason(dayData, c("Mo"))
  
  resultData = merge(dayData, data, by.x = c(dataIdCol, "Y", "Mo","D"), by.y = c(dataIdCol, "datodY", "datodMo","datodD"), all.x = TRUE)
  colnames(resultData)[c(5:9)] = c("praha", paste("idx",raster,sep=""),paste("x",raster,sep=""),paste("idy",raster,sep=""),paste("y",raster,sep=""))
  
  rm(dayData)
  
  resultData = resultData[,c(1, 5:10, 2, 3, 11, 12, 4, 13, 22:45,47)]
  resultData = setMissingValues(resultData, c(14:38), 0)
  
  allRec = unique(data[, c(dataIdCol, "praha", paste("idx",raster,sep=""),paste("x",raster,sep=""),paste("idy",raster,sep=""),paste("y",raster,sep=""), "lokalitarelevance", "vzdbcs", "vzdpostabanka", "vzdprodejna", "vzdrestaurace")])

  id_old = 1
  print(nrow(allRec))
  for (r in 1:nrow(allRec)){
    id = allRec[r,dataIdCol]
    if(id_old != id) {
      #print(r)
      resultData[(resultData[, dataIdCol] == id),"lokalitarelevance"] = allRec[r,"lokalitarelevance"]
      resultData[(resultData[, dataIdCol] == id),"vzdbcs"] = allRec[r,"vzdbcs"]
      resultData[(resultData[, dataIdCol] == id),"vzdpostabanka"] = allRec[r,"vzdpostabanka"]
      resultData[(resultData[, dataIdCol] == id),"vzdprodejna"] = allRec[r,"vzdprodejna"]
      resultData[(resultData[, dataIdCol] == id),"vzdrestaurace"] = allRec[r,"vzdrestaurace"]
      id_old = id
    }
  }
  resultData
}

getTimeSeriesData<-function(data, raster, modulo = 50)
{
  dataIdCol = paste("recId",raster,sep = "")
  allRec = unique(data[, c(dataIdCol, paste("x",raster,sep=""), paste("y",raster,sep=""),"praha")])
  id = min(allRec[,dataIdCol])
  tmpTimeSerie <- data[data[,dataIdCol] == id & order(data$date), c("date", "crimecount")]
  tmpTimeSerie$date = as.Date(tmpTimeSerie$date)
  resultData <- as.data.frame(t(c(id, id, id, id, tmpTimeSerie[,2])))
  names(resultData) = c("id", "x", "y", "praha", format(t(tmpTimeSerie[1:nrow(tmpTimeSerie),1]), "%Y-%m-%d"))
  resultData <- resultData[0,]
  tmpResultData <- resultData[0,]
  tmpRecCounter = 1
  cou = 0
  for(rec in 1:nrow(allRec)) {
    if(rec%%modulo == 0){
      print(rec)
      resultData = rbind(resultData, tmpResultData)
      tmpResultData = resultData[0,]
      tmpRecCounter = 1
    }
    id = allRec[rec,dataIdCol]
    tmpTimeSerie = data[data[,dataIdCol] == id & order(data$date), c("date", "crimecount")]
    row = nrow(tmpTimeSerie)
    tmpResultData[tmpRecCounter,] <-t(c(id, allRec[rec,2], allRec[rec,3], allRec[rec,4], tmpTimeSerie[,2]))
    tmpRecCounter = tmpRecCounter+1
    cou = cou + allRec[rec,4]
  }
  resultData = rbind(resultData, tmpResultData)
  resultData
}

splitTimeseriesData<-function(data, interval, dateFrom, dateTo, modulo = 50){
  days <- seq(from=as.Date(dateFrom), to=as.Date(dateTo), by='days')
  resultData = data[1, 1:4]
  resultData[, c("date", "crimecount", paste("d", 1:interval, sep=""))] = 0
  resultData$date <- as.Date(resultData$date, origin="1970-01-01")
  resultData = resultData[0,]
  tmpResultData = resultData[0,]
  resultCounter = 1
  for(i in (5+interval):(ncol(data))){
    if((i%%modulo) == 0) {
      print(i)
      resultData = rbind(resultData, tmpResultData)
      resultCounter = 1
      tmpResultData = tmpResultData[0,]
    }
    dataLenght = nrow(data)
    end = resultCounter + dataLenght - 1
    tmpResultData[resultCounter:end, 1:4] = data[1:dataLenght,1:4]
    tmpResultData[resultCounter:end, 5] = days[i-4]
    tmpResultData[resultCounter:end, 6] = data[1:dataLenght,i]
    tmpResultData[resultCounter:end, 7:(interval+6)] = data[1:dataLenght,(i-interval):(i-1)]
    resultCounter = end + 1
  }
  resultData = rbind(resultData, tmpResultData)
  resultData = resultData[order(resultData$x, resultData$y, resultData$date), ]
  resultData
}

plotHistogram<-function(data, column, xaxis, yaxis, ylim)
{
  ggplot(data=data, aes(column)) +
    geom_histogram(breaks=seq(min(column), max(column), by = 1),
                   col="white",
                   fill="gray",
                   alpha = .5) +
    labs(x=xaxis, y=yaxis) +
    xlim(c(min(column)-1, max(column)+1)) +
    ylim(ylim)
}

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}