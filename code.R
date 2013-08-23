

opts_chunk$set(comment=NA, prompt=TRUE)




data(mtcars)
model1 <- lm(mpg ~ disp + hp + drat + wt + as.factor(cyl) + as.factor(gear),
             data = mtcars)



model1



args(lm)



names(model1)



summ1 <- summary(model1)



summ1



summ1$coef



class(summ1$coef)



par(mfrow=c(2,2)) # Arrange in 2x2 grid
plot(model1)



require(xtable)
print(xtable(model1), type='html')



data(infert)
model2 <- glm(case~spontaneous + induced, data=infert, family=binomial())
model2



summary(model2)$coef



for(i in 1:3) esoph[,i] <- as.factor(as.character(esoph[,i]))
model3 <- glm(cbind(ncases, ncontrols) ~ agegp + tobgp * alcgp, data=esoph,
              family=binomial())
model3



counts <- c(18,17,15,20,10,20,25,13,12)
outcome <- gl(3,1,9)
treatment <- gl(3,3)
d.AD <- data.frame(treatment, outcome, counts)
model4 <- glm(counts ~ outcome + treatment, family = poisson())
model4



summary(model4)$coef



print(xtable(model4), type='html')



require(randomForest)
rf1 <- randomForest(mpg~., data=mtcars, importance=T)
varImpPlot(rf1)



library(ggplot2)
p1 <- predict(rf1)
qplot(mtcars$mpg, p1, xlab='True', ylab='predicted')+
  geom_abline(color='red') +
  geom_smooth()



sqrt(mean((mtcars$mpg - p1)^2))



purl('index.Rmd',output='code.R', documentation=0L)


