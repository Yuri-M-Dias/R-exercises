# Ambient configuration
currentPwd <- getwd()
print(paste("Saving graphics to: ", currentPwd, sep = ""))
nameAndData <- "Yuri Matheus Dias Pereira - 20/11/2016"

# Data
dataUniform <- runif(1000)
dataRandomNorm <- rnorm(1000, 5, 1)
dataRandomPois <- rpois(1000, lambda = 4)

# Question 1
pdf("resultado_1.pdf")
par(mfrow = c(1, 1))
hist(dataRandomPois, xlab = "Data com Poisson", main = nameAndData)
abline(h = median(dataRandomPois))
dev.off()

# Question 2
pdf("resultado_2.pdf")
par(mfrow = c(1, 1))
zeroADez <- 0:45
funcaoTrigo1 <- sin(zeroADez)
funcaoTrigo2 <- cos(zeroADez)
funcaoTrigo3 <- cos(zeroADez ** 3)
plot(zeroADez, funcaoTrigo1, col=9, lwd=3, t='l', main = nameAndData)
points(zeroADez, funcaoTrigo2, col=2, t='l', lwd=2)
points(zeroADez, funcaoTrigo3, col=5, t='l', lwd=2)
#legend(x = 0.4, y = 35, legend = "Bogus")
dev.off()
