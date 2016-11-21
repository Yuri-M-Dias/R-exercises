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

# Constants
# Probably better as an argument?
DATA_FILE_PATH <- 'data/metoriteDate.json'
# Just testing out how constants work
#lockBinding("DATA_FILE_PATH", globalenv())

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
                                   print(paste("Variable:", dataColumnsNames[columnIndex] , sep = " "))
                                   sapply(data, function(element)
                                     readDimension(element, columnIndex))
                                 }),
                          stringsAsFactors = FALSE)
  names(dataFrame) <- dataColumnsNames
  # TODO: make this another function, just to separate these transformations
  # Formats latitude and longitude
  dataFrame$reclat <- as.numeric(dataFrame$reclat)
  dataFrame$reclong <- as.numeric(dataFrame$reclong)
  dataFrame$'mass (g)' <- as.numeric(dataFrame$'mass (g)')
  dataFrame$year <- as.Date(dataFrame$year)
  return(dataFrame)
}

# Reads data
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

#Strips NA
massData <- na.omit(formatedData$`mass (g)`)

normalizeVector <- function(dataVector) {
  normalizedData <- (dataVector - min(dataVector)) / (max(dataVector)-min(dataVector))
  return(normalizedData)
}

normalizedMassData <- normalizeVector(massData)

summary(normalizedMassData)

hist(normalizedMassData)
boxplot(massData, outline = F)
