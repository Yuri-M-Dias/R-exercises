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
library("ggplot2")
library("maptools")

# Constants
DATA_FILE_PATH <- 'data/metoriteDate.json'
# Just testing out how constants work
#lockBinding("DATA_FILE_PATH", globalenv())
# Allows fully use of maptools
gpclibPermit()

# Sets current dir as working
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

currentPwd <- getwd()
cat("Saving graphics to: ", currentPwd, "\n", sep = "")

#Functions
readDimension <- function(element, position) {
  if (is.null(element[[position]])) {
    return(NA)
  }
  return(trim(element[[position]]))
}

readData <- function(data, metaData, dataColumnsNames, numberOfColumns) {
  dataFrame <- data.frame(sapply(1:numberOfColumns,
                                 function(columnIndex) {
                                   cat("Variable:", dataColumnsNames[columnIndex],"\n", sep = " ")
                                   sapply(data, function(element)
                                     readDimension(element, columnIndex))
                                 }),
                          stringsAsFactors = FALSE)
  names(dataFrame) <- dataColumnsNames
  # Formats latitude and longitude
  dataFrame$reclat <- as.numeric(dataFrame$reclat)
  dataFrame$reclong <- as.numeric(dataFrame$reclong)
  dataFrame$mass <- as.numeric(dataFrame$'mass (g)')
  dataFrame$year <- as.Date(dataFrame$year)
  #Strips all rows with a single NA
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
dataColumnsNames <- unlist(sapply(1:numberOfColumns,
                                  function(element) {
                                    return(dataColumns[[element]]$name)
                                  }))
formatedData <- readData(meteoritesData, metaData, dataColumnsNames, numberOfColumns)
worldShape <- readShapePoly("data/ne_110m_land.shp")
cat("Data file read with success\n")

par(mfrow = c(1, 2))

massData <- formatedData$mass
normalizedMassData <- normalizeVector(massData)
summary(normalizedMassData)
hist(normalizedMassData)
boxplot(massData, outline = F)

formatedData.coordinates = formatedData[c("reclong", "reclat")]
coordinates(formatedData.coordinates) <- ~reclong + reclat
plot(formatedData.coordinates)

biggerMeteorites <- formatedData$mass > 5000
plot(formatedData.coordinates[biggerMeteorites,], col=2, pch=7)
plot(worldShape, add=T)

# Aqui tem o código do exercício 3
years <- formatedData$year
aggregatedYears <- aggregate(x = years,
                             by = list(year = substr(years, 0, 4)),
                             FUN = length)
aggregatedYears$year <- as.numeric(aggregatedYears$year)
aggregatedYears <- subset(aggregatedYears, year < 2016 & year > 1985)

attach(aggregatedYears)

plot(year, x, xlab = 'Ano', ylab = 'Meteoritos encontrados', t='l')
otherVariable <- year ** 3
model <- lm(x ~ year * otherVariable)
lines(year, predict(model), col=3)
legend(max(year) - 8, max(x) - 2, c("Dados", "Predição"),
       col = c(9, 3), lty = c(1,1), bty = 'l')
summary(year)
summary(x)
summary(model)

detach(aggregatedYears)
