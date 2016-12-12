# Ambient configuration
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
currentPwd <- getwd()
cat("Saving graphics to: ", currentPwd, sep = "")
nameAndData <- "Yuri Matheus Dias Pereira - 7/12/2016"

dados <- read.csv2(file = "acidentes_trabalho_por_ano.csv", encoding = 'UTF-8')
