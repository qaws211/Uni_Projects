rm(list=ls())
library(pROC)
current_path<-getActiveDocumentContext()$path
setwd(dirname(current_path))
print(getwd())
library(dplyr)
library(tidyverse)
library(GGally)
library(carData)
library(data.table)
library(ggplot2)
library(ggrepel)
# Data cleaning
hac<-read.csv("HappinessAlcoholConsumption.csv")
View(hac)
hac$Hemisphere <- str_replace(hac$Hemisphere, "noth", "north")
hac$Hemisphere <- str_replace(hac$Hemisphere, "both", "south")

hac<- hac[,(-6)]#tolgo il gdp perche è sbagliato

#Explorative Analysis
summary(hac)

#logistica
hac$Hemisphere<-ifelse(hac$Hemisphere=="north",1,0)
library(aod)
library(lmtest)





#training and testing
set.seed(123)

#utilizzo l'80% dei dati come training e il 20% come testing
sample <- sample(c(TRUE, FALSE), nrow(hac), replace=TRUE, prob=c(0.75,0.25))
train <- hac[sample, ]
test <- hac[!sample, ]  


library(pscl)
library(car)
library(caret)
library(randomForest)
#Logisti regression applied to train dataset
model_full<-glm(Hemisphere~.,data=train, family="binomial")
logit1<-glm(Hemisphere ~  Beer_PerCapita + Spirit_PerCapita +HDI +HappinessScore ,data=train, family="binomial")
lrtest(model_full,logit1) #Since this p-value is not less than .05, we will fail to reject the null hypothesis.We use the nested model

logit2<-glm(Hemisphere ~  Beer_PerCapita + Spirit_PerCapita +HDI  ,data=train, family="binomial")
lrtest(logit1,logit2)# we use the nested model again

logit3<-glm(Hemisphere ~   Spirit_PerCapita +HDI  ,data=train, family="binomial")
lrtest(logit2,logit3)# this  time we fail to reject the null hipothesys so we use the model  logit2

library(aod)
wald.test(Sigma = vcov(logit2), b = coef(logit2), Terms = 1:3)#Since this p-value is less than .05,
                                                        #we reject the null hypothesis of the Wald test.
                                                        #this means that this coefficients are significant

summary(logit2)
pR2(logit2)["McFadden"]
vif(logit2) 
varImp(logit2) 



new <- data.frame(Beer_PerCapita = 300, Spirit_PerCapita = 300 , HDI=600) #VALORI bassi per tutte le variabili
predict(logit2, new, type="response")#mi dice che probabilita ha new di far parte del l'emisfero nord

predicted<-predict(logit2,test,type="response")# calcola la probabilita diogni individuo del  dataset test , di far parte del emisfero nord, basandoci sul modello del train
predicted<-as.data.frame((predicted))

#Roc curve
par(pty="s")

roc(test$Hemisphere, predicted$`(predicted)`, plot=TRUE,legacy.axes=TRUE, percent=TRUE,
    xlab="False Positive Percentage", ylab="True Postive Percentage",col="blue", lwd=4, print.auc=TRUE)
#Random Forest
rf.model <- randomForest(factor(Hemisphere) ~ Beer_PerCapita + Spirit_PerCapita +HDI,data=test)
plot.roc(test$Hemisphere, rf.model$votes[,1], percent=TRUE, col="darkgreen", lwd=4, print.auc=TRUE, add=TRUE, print.auc.y=40)
legend("bottomright", legend=c("Logisitic Regression", "Random Forest"), col=c("blue", "darkgreen"), lwd=4)
par(pty="s")
#Finding optimal threshold using roc curve
roc.info <- roc(test$Hemisphere, predicted$`(predicted)`, legacy.axes=TRUE)
str(roc.info)


roc.df <- data.frame(
  tpp=roc.info$sensitivities*100, ## tpp = true positive percentage
  fpp=(1 - roc.info$specificities)*100, ## fpp = false positive precentage
  thresholds=roc.info$thresholds)


head(roc.df)
tail(roc.df)

roc.df[roc.df$tpp > 65 & roc.df$tpp < 76,]

#Settiamo il threshold e valutiamo la nostra matrice di confusione
predicted_b<-ifelse(predicted> 0.8638175,1,0) #Setto il cutoff
predicted_b<-as.data.frame((predicted_b))
colnames(predicted_b)[1] ="predicted_b_col"


bind<-cbind(test$Hemisphere,predicted_b)

#Confusion Matrix
test$Hemisphere<-as.factor(test$Hemisphere)
str(test$Hemisphere)
predicted_b$predicted_b_col<- as.factor(predicted_b$predicted_b_col)
str(predicted_b$predicted_b_col)



cf<-confusionMatrix( test$Hemisphere,predicted_b$predicted_b_col)
cf
#calculate precision
precision(test$Hemisphere, predicted_b$predicted_b_col)

#calculate sensitivity
sensitivity(test$Hemisphere, predicted_b$predicted_b_col)
#calculate specificity
specificity(test$Hemisphere, predicted_b$predicted_b_col)

dev.new()
fourfoldplot(as.table(cf), color = c("magenta", "green"), main = "Confusion Matrix")











