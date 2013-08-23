

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



set.seed(135793)
library(caret)
indx.train <- createDataPartition(y=1:nrow(mtcars), p=0.7, list=F)
mtcars.train <- mtcars[indx.train,]
mtcars.test <- mtcars[-indx.train,]



require(randomForest)
rf1 <- randomForest(mpg~., data=mtcars.train, importance=T)
varImpPlot(rf1)



library(ggplot2)
p1 <- predict(rf1, newdata=mtcars.test)
qplot(mtcars.test$mpg, p1, xlab='True', ylab='predicted')+
  geom_abline(color='red') +
  geom_smooth()



sqrt(mean((mtcars$mpg - p1)^2))



library(AppliedPredictiveModeling)
data(twoClassData, package='AppliedPredictiveModeling')
twocl <- cbind(classes, predictors)
indx.train <- createDataPartition(twocl$classes,p=.5, list=F)
twocl.train <- twocl[indx.train,]
twocl.test <- twocl[-indx.train,]
str(twocl)



library(gbm)
twocl.train <- transform(twocl.train, classes1=ifelse(classes=='Class2',1,0))
twocl.test <- transform(twocl.test, classes1=ifelse(classes=='Class2',1,0))
model5 <- gbm(classes1~., data=twocl.train, n.trees=1000,cv.folds=5)
p5 <- predict(model5, newdata=twocl.test, n.trees=500, type='response')



model6 <- randomForest(classes~., data=twocl.train)
p6 <- predict(model6, newdata=twocl.test, type='prob')[,2]



misclas5 <- mean((twocl.test$classes=='Class2') != (p5 > 0.5))
misclas6 <- mean(twocl.test$classes != predict(model6, newdata=twocl.test))
data.frame('GBM'=misclas5, 'RF'=misclas6)



library(ROCR)
pred5 <- prediction(p5, twocl.test$classes)
perf5 <- performance(pred5, 'tpr','fpr')
plot(perf5)



library(ROCR)
pred6 <- prediction(p6, twocl.test$classes)
perf6 <- performance(pred6, 'tpr','fpr')
plot(perf6)



extract.auc <- function(pred){
  require(ROCR)
  perf <- performance(pred, 'auc')
  paste('AUC =', perf@y.values)
}
data.frame("GBM"=extract.auc(pred5), "RF"=extract.auc(pred6))



t.end   <- 10^5 # duration of sim
t.clock <- 0    # sim time
Ta <- 1.3333    # interarrival period
Ts <- 1.0000    # service period
t1 <- 0         # time for next arrival
t2 <- t.end     # time for next departure
tn <- t.clock   # tmp var for last event time
tb <- 0         # tmp var for last busy-time start
n <- 0          # number in system
b <- 0          # total busy time
c <- 0          # total completions
qc <- 0         # plot instantaneous q size
tc <- 0         # plot time delta
plotSamples <- 100
set.seed(1)



source('rundes.R')



plot(tc,qc,type='s',xlab='Time',ylab='Instantaneous queue length', 
     main='M/M/1 simulation')


source('rundes.R')



purl('index.Rmd',output='code.R', documentation=0L)


