# Sandbox for testing the project, with various helpful links
# Data comes from: https://data.nasa.gov/Space-Science/Meteorite-Landings/gh4g-9sfh
# Tutorial on reading from an Open Data Portal:
# http://zevross.com/blog/2015/02/12/using-r-to-download-and-parse-json-an-example-using-data-from-an-open-data-portal/

# Dependencies
library("rjson")
library("gdata")

# Constants
# Probably better as an argument?
DATA_FILE_PATH <- 'metoriteDate.json'
# Just testing out how constants work
#lockBinding("DATA_FILE_PATH", globalenv())

#Functions
readDimension <- function(element, position){
  if(is.null(element[[position]])){
    return(NA)
  }
  return(trim(element[[position]]))
}

readInfoFromSingleVariable <- function(position, data) {
  print(paste("Variable", position, sep=" "))
  sapply(data, function(element) readDimension(element, position))
}

readData <- function(data, metaData) {
  # Ignores GeoLocation for now
  numberOfColumns <- length(metaData[["view"]][["columns"]]) - 1
  dataFrame <- data.frame(
    sapply(1:numberOfColumns,
           function(columnIndex){ readInfoFromSingleVariable(columnIndex, data) }
           ),
    stringsAsFactors=FALSE
    )
  return(dataFrame)
}

getColumnName <- function(columns, elementIndex){
  subColumnTypes <- columns[[elementIndex]]$subColumnTypes
  if(is.null(subColumnTypes)){
    return(columns[[elementIndex]]$name)
  }else{
    return(subColumnTypes)
  }
}

# Reads data
rawJsonData <- fromJSON(file = DATA_FILE_PATH)

metaData <- rawJsonData[['meta']]
meteoritesData <- rawJsonData[['data']]
dataColumns <- metaData[['view']][['columns']]

# do the extraction and assembly
dataColumnsNames <- unlist(
  sapply(1:length(dataColumns),
         function(element) getColumnName(dataColumns, element))
)
formatedData <- readData(meteoritesData, metaData)
names(formatedData) <- dataColumnsNames

