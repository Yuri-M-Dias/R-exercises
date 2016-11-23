# Ambient configuration
currentPwd <- getwd()
print(paste("Saving graphics to: ", currentPwd, sep = ""))
nameAndData <- "Yuri Matheus Dias Pereira - 23/11/2016"

maiorValor <- function(lista){
  maximo <- 0
  for (elemento in lista){
    if(elemento > maximo){
      maximo <- elemento
    }
  }
  return(maximo)
}

listaExemplo <- 0:100
valorCalculado <- maiorValor(listaExemplo)
valorCalculado <- maiorValor(listaExemplo)

