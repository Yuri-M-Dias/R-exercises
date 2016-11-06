# Sandbox for testing the project, with various helpful links
# Data comes from https://data.nasa.gov/Space-Science/Meteorite-Landings/gh4g-9sfh
# Tutorial on reading from an Open Data Portal
# http://zevross.com/blog/2015/02/12/using-r-to-download-and-parse-json-an-example-using-data-from-an-open-data-portal/

# Dependencies (should be in Packrat? What about build and packaging tools?)
library("rjson")
library("gdata")

# Reads data
filePath <- paste(getwd(), "/metoriteDate.json", sep = "")
json_data_raw <- fromJSON(file = filePath)

meteorites <- json_data_raw[["data"]]

returnData<-function(x, var){
  if(is.null(x[[var]])){
    return(NA)
  }
  return(trim(x[[var]]))
}

grabInfo <- function(var){
  print(paste("Variable", var, sep=" "))  
  sapply(meteorites, function(x) returnData(x, var)) 
}

# do the extraction and assembly
fmDataDF<-data.frame(sapply(1:17, grabInfo), stringsAsFactors=FALSE)

meteoritesCitiesNames <- sapply(meteorites, function(x) x[[9]])

