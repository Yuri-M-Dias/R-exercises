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
par(xpd=TRUE)
xAxis <- 0:45
yAxis1 <- sin(xAxis)
yAxis2 <- cos(xAxis)
yAxis3 <- cos(xAxis ** 3)
plot(xAxis, yAxis1, ylim = c(-1, 1.5), col=9, type = 'o', lwd=3, pch = 1, main = nameAndData)
points(xAxis, yAxis2, col=2, type = 'o', lwd=2, pch = 2)
points(xAxis, yAxis3, col=11, type = 'o', lwd=1, pch = 3)
legend(35, 1.5, c("sin(x)", "cos(x)", "cos(x^3)"),col = c(9, 2, 11), pch = c(1,2,3), lty = c(1,2,3), bty = 'l')
dev.off()
