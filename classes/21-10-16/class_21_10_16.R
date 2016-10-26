# Classe 26-10-16

# Ambient configuration
par(mfrow = c(2, 2))

# Data
uniformData <- runif(100)
randomData <- rnorm(100, 5, 1)

# Plots
stem(uniformData)
stem(randomData)

hist(uniformData, xlab = "alunos", ylab = "Frequência", main = "Título qualquer")
abline(h = mean(uniformData))

hist(randomData, xlab = "alunos", ylab = "Frequência", main = "Título qualquer",
     xlim = c(0, 10), ylim = c(0, 20))
abline(h = mean(randomData))

plot(uniformData, randomData)
boxplot(randomData)
barplot(randomData)

# Intermission
pdf("temp1.pdf")
par(mfrow=c(2,2))
hist(runif(10), freq=F)
hist(runif(100), freq=F)
hist(runif(1000), freq=F)
hist(runif(10000), freq=F)
dev.off()

# Int
x <- c(12, 10, 18)
names(x) <- c("Física", "Matemática", "Química")
barplot(x, main="Número de Alunos")
pie(x, main="Número de Alunos")

# Better graphics
par(mfrow=c(1,2))
x <- -10:10
y <- x^2 + 3*x - 1
plot(x, y, col=9, cex=.5, lwd=3)

y2 <- x^2 + 2*x + 2
plot(x, y, t='l', col=4, cex=.5, lwd=3, xlim=c(-10,10))
points(x, y2, col=3, t='l', lwd=2)

y3 <- x^3 + 2*x^2 + 2
points(x, y3, col=2, t='l', lwd=2)
