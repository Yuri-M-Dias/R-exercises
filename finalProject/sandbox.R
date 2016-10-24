library("rjson")

json_data <- fromJSON(file="R-exercises/finalProject/metoriteDate.json")
summary(json_data)
sapply(json_data, class)
plot(json_data)