# Simples função para calcular o máximo de um vetor
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

listaExemplo <- rnorm(1000, 5, 1)
valorCalculado <- maiorValor(listaExemplo)
valorCalculadoNativo <- max(listaExemplo)
cat(valorCalculado, " = ", valorCalculadoNativo)

