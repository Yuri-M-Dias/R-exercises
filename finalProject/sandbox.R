library("rjson")

filePath <- paste(getwd(), "/metoriteDate.json", sep = "")

json_data_raw <- fromJSON(file = filePath)
meteorites <- json_data_raw[["data"]]
meteoritesCitiesNames <- sapply(meteorites, function(x) x[[9]])

# To look for later
# http://zevross.com/blog/2015/02/12/using-r-to-download-and-parse-json-an-example-using-data-from-an-open-data-portal/
