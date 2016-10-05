x <- c(9,10,9.5,8,6.5)
mean(x)
sum(x)
length(x)
media <- sum(x)/length(x)
media = function(x) {
    sum(x)/length(x)
}
media(x)

sort(x)
median(x)
mediana <- function(x) {
    x <- sort(x)
    a <- length(x) %/% 2
    if (length(x) %% 2 == 1) { mediana <- x[a+1]}
    else { mediana <- (x[a] + x[a+1])/2}
    return(mediana)
}
mediana(x)

# Média ponderada
x <- c(6.5, 4.5, 10)
mean(x)
w <- c(4, 4, 2)
weighted.mean(x, w)
x * w
sum(x * w) / sum(w)
MP <- function(x,w) {
    sum(x*w) / sum(w)
}
MP(x, w)

sd(x)
var(x)
sqrt(var(x))
max(x)
min(x)
x <- sample(1:6, 10, replace=T)
x
max(x)
min(x)
range(x)
range(x)[1] # Max
range(x)[2] # Min
x <- rnorm(100, 0, 1)
min(x)
max(x)
range(x)
range(x)[2] - range(x)[1]
max(x) - min(x)
which.max(x)

x <- c(4,2,4,6,8,9,1,7)
sort(x)
order(x)
median(x)
quantile(x)

x <- rnorm(100, 0, 1)
mean(x)
median(x)
quantile(x)
quantile(x, c(0.1, 0.25, 0.40, 0.5, 0.75, 0.90))

summary(x)
summary(x)[1]
