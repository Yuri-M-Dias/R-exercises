library("rjson")

# Data comes from https://data.nasa.gov/Space-Science/Meteorite-Landings/gh4g-9sfh
filePath <- paste(getwd(), "/metoriteDate.json", sep = "")

json_data_raw <- fromJSON(file = filePath)
meteorites <- json_data_raw[["data"]]
meteoritesCitiesNames <- sapply(meteorites, function(x) x[[9]])
meteoritesCitiesNames <- sapply(meteorites, function(x) x[[9]])

# To look for later
# http://zevross.com/blog/2015/02/12/using-r-to-download-and-parse-json-an-example-using-data-from-an-open-data-portal/

# Para o trabalho final(mandar uma tarball/zip):
# Relatório -> PDF, como pegou os dados, quais tipos de dados, se teve que classificar
# Código .R -> source("file.R")
# Figuras (plots)
# E os dados em si
