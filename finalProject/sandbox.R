# Sandbox for testing the project, with various helpful links
# Data comes from: https://data.nasa.gov/Space-Science/Meteorite-Landings/gh4g-9sfh
# Tutorial on reading from an Open Data Portal:
# http://zevross.com/blog/2015/02/12/using-r-to-download-and-parse-json-an-example-using-data-from-an-open-data-portal/

# Dependencies
# Reads json
library("rjson")
# Trim function(removes spaces)
library("gdata")
# Some more read options
#library("rgdal")
# better graphics, supposedly
#library("ggplot2")
library("maptools")

# Constants
DATA_FILE_PATH <- 'data/metoriteDate.json'
# Just testing out how constants work
#lockBinding("DATA_FILE_PATH", globalenv())
# Allows fully use of maptools
gpclibPermit()

# Sets current dir as working
#this.dir <- dirname(parent.frame(2)$ofile)
#setwd(this.dir)

currentPwd <- getwd()
cat("Saving graphics to: ", currentPwd, "\n", sep = "")

#Functions
readDimension <- function(element, position) {
  elementToRead <- element[[position]]
  if (is.null(elementToRead)) {
    return(NA)
  }
  return(trim(elementToRead))
}

readData <- function(data, metaData, dataColumnsNames, numberOfColumns) {
  dataFrame <- data.frame(sapply(
    X = 1:numberOfColumns,
    FUN = function(columnIndex) {
      cat("Variable:", dataColumnsNames[columnIndex],"\n", sep = " ")
      sapply(data, function(element)
        readDimension(element, columnIndex))
    }),
    stringsAsFactors = FALSE
  )
  names(dataFrame) <- dataColumnsNames
  # Formats latitude and longitude
  dataFrame$reclat <- as.numeric(dataFrame$reclat)
  dataFrame$reclong <- as.numeric(dataFrame$reclong)
  dataFrame$mass <- as.numeric(dataFrame$'mass (g)')
  dataFrame$year <- as.Date(dataFrame$year)
  # Strips all rows with a NA
  dataFrame <- dataFrame[complete.cases(dataFrame),]
  return(dataFrame)
}

normalizeVector <- function(dataVector) {
  normalizedData <- (dataVector - min(dataVector)) / (max(dataVector)-min(dataVector))
  return(normalizedData)
}

# Reads data
cat("Reading data from: ", DATA_FILE_PATH, "\n")
rawJsonData <- fromJSON(file = DATA_FILE_PATH)

metaData <- rawJsonData[['meta']]
meteoritesData <- rawJsonData[['data']]
dataColumns <- metaData[['view']][['columns']]
# Ignores GeoLocation for now
numberOfColumns <- length(dataColumns) - 1

# do the extraction and assembly
dataColumnsNames <- unlist(sapply(
  X = 1:numberOfColumns,
  FUN = function(element) {
    return(dataColumns[[element]]$name)
  })
)
formatedData <- readData(meteoritesData, metaData, dataColumnsNames, numberOfColumns)
worldShape <- readShapePoly("data/world-50m/ne_50m_admin_0_countries.shp")
cat("Data file read with success\n")

massData <- formatedData$mass
normalizedMassData <- normalizeVector(massData)
summary(normalizedMassData)
hist(normalizedMassData)
boxplot(massData, outline = F)

# Primeiro plot: Localização geográfica das quedas
#pdf("plot1.pdf")
formatedData$coordinates = formatedData[c("reclong", "reclat")]
coordinates(formatedData$coordinates) <- ~reclong + reclat

biggerMeteorites <- formatedData$mass > 5000
plot(worldShape)
pointsSize <- biggerMeteorites / max(biggerMeteorites)
points(
  x = formatedData$coordinates[biggerMeteorites,],
  col=3,
  pch=19,
  cex=pointsSize
)
# O plano é fazer isso de acordo com a massa

# Segundo plot: boxplot de acordo algumas classes agrupadas por número de vezes que apareceram
#pdf("plot2.pdf")
classes <- unique(formatedData$recclass)
aggregatedClasses <- aggregate(
  formatedData$recclass,
  by = list(class = formatedData$recclass),
  FUN = length
)
orderedAggregatedClasses <- aggregatedClasses[order(aggregatedClasses$x, decreasing = TRUE),]
tenMostCommonClasses <- head(orderedAggregatedClasses, 10)
classBarPlot <- barplot(
  height = tenMostCommonClasses$x, names.arg=tenMostCommonClasses$class,
  horiz = T, space = 0.1, main = "Classes mais comuns de meteoritos encontradas"
)
text(0, classBarPlot, labels = tenMostCommonClasses$x, cex=.8, pos=4)

# Terceiro plot: meteoritos pela média de tamanho/classe
#pdf("plot3.pdf")
aggregatedClassByMass <- aggregate(
  x = formatedData,
  by = list(class = formatedData$recclass, mass = formatedData$mass),
  FUN = mean
)

# Aqui tem o código do exercício 3
#pdf("plot4.pdf")
years <- formatedData$year
aggregatedYears <- aggregate(
  x = years,
  by = list(year = substr(years, 0, 4)),
  FUN = length
)
aggregatedYears$year <- as.numeric(aggregatedYears$year)
aggregatedYears <- subset(aggregatedYears, year < 2012 & year > 1985)

attach(aggregatedYears)

plot(year, log10(x), xlab = 'Ano', ylab = 'Meteoritos encontrados', t='p')
otherVariable <- year ** 3
model <- lm(log10(x) ~ year + otherVariable)
lines(year, predict(model), col=3)
legend(
  max(year) - 8, max(x) - 2, c("Dados", "Predição"),
  col = c(9, 3), lty = c(1,1), bty = 'p'
)
summary(year)
summary(x)
summary(model)

detach(aggregatedYears)
