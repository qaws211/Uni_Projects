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
hac0<-read.csv("HappinessAlcoholConsumption.csv")
View(hac0)
hac0$Hemisphere <- str_replace(hac0$Hemisphere, "noth", "north")
hac0$Hemisphere <- str_replace(hac0$Hemisphere, "both", "south")


hac<- hac0[,-c(1,2,4,6)]#tolgo il gdp perche è sbagliato
#Random Forest
summary(hac)


#hac$Hemisphere<-ifelse(hac$Hemisphere=="north",1,0)
library(aod)

library(randomForest)
library(cowplot)

set.seed(42)

## NOTE: For most machine learning methods, you need to divide the data
## manually into a "training" set and a "test" set. This allows you to train 
## the method using the training data, and then test it on data it was not
## originally trained on. 
##
## In contrast, Random Forests split the data into "training" and "test" sets 
## for you. This is because Random Forests use bootstrapped
## data, and thus, not every sample is used to build every tree. The 
## "training" dataset is the bootstrapped data and the "test" dataset is
## the remaining samples. The remaining samples are called
## the "Out-Of-Bag" (OOB) data.

##data.imputed <- rfImpute(Hemisphere ~ ., data = hac, iter=6)
hac$Hemisphere <- as.character(hac$Hemisphere)
hac$Hemisphere <- as.factor(hac$Hemisphere)
model <- randomForest(Hemisphere ~ ., data=hac, proximity=TRUE)
model

# valutiamo gli errori commessi utilizzando un RF con 500 alberi
oob.error.data <- data.frame(
  Trees=rep(1:nrow(model$err.rate), times=3),
  Type=rep(c("OOB", "north", "south"), each=nrow(model$err.rate)),
  Error=c(model$err.rate[,"OOB"], 
          model$err.rate[,"north"], 
          model$err.rate[,"south"]))

ggplot(data=oob.error.data, aes(x=Trees, y=Error)) +
  geom_line(aes(color=Type))



#vediamo con 1000 alberi
model <- randomForest(Hemisphere ~ ., data=hac,ntree=1000, proximity=TRUE)

model

oob.error.data <- data.frame(
  Trees=rep(1:nrow(model$err.rate), times=3),
  Type=rep(c("OOB", "north", "south"), each=nrow(model$err.rate)),
  Error=c(model$err.rate[,"OOB"], 
          model$err.rate[,"north"], 
          model$err.rate[,"south"]))

ggplot(data=oob.error.data, aes(x=Trees, y=Error)) +
  geom_line(aes(color=Type))

tail(model$err.rate)
#vediamo con 1500
model <- randomForest(Hemisphere ~ ., data=hac,ntree=1500, proximity=TRUE)

model

oob.error.data <- data.frame(
  Trees=rep(1:nrow(model$err.rate), times=3),
  Type=rep(c("OOB", "north", "south"), each=nrow(model$err.rate)),
  Error=c(model$err.rate[,"OOB"], 
          model$err.rate[,"north"], 
          model$err.rate[,"south"]))

ggplot(data=oob.error.data, aes(x=Trees, y=Error)) +
  geom_line(aes(color=Type))

tail(model$err.rate)

dev.new()
varImpPlot(model)
## Blue line = The error rate specifically for calling "south" countries that
## are OOB.
##
## Green line = The overall OOB error rate.
##
## Red line = The error rate specifically for calling "north" countries 
## that are OOB.

#valutiamo il numero di variabili che vanno(mtry) prese all'inizio 
## If we want to compare this random forest to others with different values for
## mtry (to control how many variables are considered at each step)...
# oob.values <- vector(length=4)
# for(i in 1:4) {
#   temp.model <- randomForest(Hemisphere ~ ., data=hac, mtry=i, ntree=1500)
#   oob.values[i] <- temp.model$err.rate[nrow(temp.model$err.rate),1]
# }
# 
# oob.values
# ## find the minimum error
# min(oob.values)
# ## find the optimal value for mtry...
# which(oob.values == min(oob.values))
# ## create a model for proximities using the best value for mtry
# #model <- randomForest(Hemisphere ~ ., 
#                       data=hac,
#                       ntree=1500, 
#                       proximity=TRUE, 
#                       mtry=2)
# 
# 
# model
#PCoa o MDS
distance.matrix <- as.dist(1-model$proximity)

mds.stuff <- cmdscale(distance.matrix, eig=TRUE, x.ret=TRUE)

## calculate the percentage of variation that each MDS axis accounts for...
mds.var.per <- round(mds.stuff$eig/sum(mds.stuff$eig)*100, 1)

## now make a fancy looking plot that shows the MDS axes and the variation:
mds.values <- mds.stuff$points
mds.data <- data.frame(Sample=rownames(mds.values),
                       X=mds.values[,1],
                       Y=mds.values[,2],
                       Status=hac$Hemisphere)
row.names<-hac0$Country

ggplot(data=mds.data, aes(x=X, y=Y, label=hac0$Country)) + 
  geom_text(aes(color=Status)) +
  theme_bw() +
  xlab(paste("MDS1 - ", mds.var.per[1], "%", sep="")) +
  ylab(paste("MDS2 - ", mds.var.per[2], "%", sep="")) +
  ggtitle("MDS plot using (1 - Random Forest Proximities)")

  

# gli assi x e y rappresentano la percentuale della varianza della distanza
# da provare con dataset scalato e con happiness score che è molto correlato


#roc della random forest

par(pty = "s") ## pty sets the aspect ratio of the plot region. Two options:

roc(hac$Hemisphere,model$votes[,1] , plot=TRUE,legacy.axes=TRUE, percent=TRUE,
    xlab="False Positive Percentage", ylab="True Postive Percentage",col="brown", lwd=4, print.auc=TRUE)


