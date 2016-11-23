# Ambient configuration
currentPwd <- getwd()
cat("Saving graphics to: ", currentPwd, sep = "")
nameAndData <- "Yuri Matheus Dias Pereira - 20/11/2016"

# Data
dataUniform <- runif(1000)
dataRandomNorm <- rnorm(1000, 5, 1)
dataRandomPois <- rpois(1000, lambda = 4)

# Question 1
pdf("resultado_1.pdf")
par(mfrow = c(1, 1))
hist(dataRandomPois, xlab = "Data com Poisson", col = 3, main = nameAndData)
abline(h = median(dataRandomPois))
dev.off()

# Question 2
pdf("resultado_2.pdf")
par(mfrow = c(1, 1))
par(xpd=TRUE)
xAxis <- seq(0, 4 * pi, l = 1000)
yAxis1 <- sin(xAxis)
yAxis2 <- cos(xAxis)
yAxis3 <- cos(xAxis) ** 3
plot(0, 0, xlim=c(0, 4 * pi), ylim = c(-1.5, 1.5),
     axes = F, xlab = 'Resultado', ylab = 'Funçao',
     type = 'n', main = nameAndData
)
axis(side=2, at = seq(-1.5, 1.5, l = 4))
axis(side=1, at = seq(0, round(4 * pi), l = 6))
points(xAxis, yAxis1, col=9, type = 'l', lwd=1, pch = 1)
points(xAxis, yAxis2, col=2, type = 'l', lwd=2, pch = 2)
points(xAxis, yAxis3, col=11, type = 'l', lwd=3, pch = 3)
legend(max(xAxis) - 3, max(yAxis1) + 0.5, c("sin(x)", "cos(x)", "cos(x)³"),
       col = c(9, 2, 11), lty = c(1,1,1), bty = 'l'
)
dev.off()
