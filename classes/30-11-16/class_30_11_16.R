# Ambient configuration
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
currentPwd <- getwd()
cat("Saving graphics to: ", currentPwd, sep = "")
nameAndData <- "Yuri Matheus Dias Pereira - 30/11/2016"

par(mfrow=c(2,1))
# Data 1 
data1 <- read.table(file = "data.txt")
attach(data1)

#TODO: legendas para as curvas, pontos dados, cores

plot(x, y)
modelo1 <- lm(y ~ x)
abline(modelo1, col=4)
x2 <- x^2
modelo3 <- lm(y ~ x + x2 + x3)
lines(x, predict(modelo3), col=3)
print(summary(modelo3))

detach(data1)

# Data 2
data2 <- read.table(file = "data2.txt")
attach(data2)

plot(x, y)
#lm (variável a ser explicada ~ variável que explica)
x2 <- x^2
x3 <- x^3
modelo4 <- lm(y ~ x3 + x2 + x)
modelo5 <- lm(y ~ x3 + x)
lines(x, predict(modelo5), col=3)
lines(x, predict(modelo4), col=4)
print(summary(modelo4))

detach(data2)
