rm(list=ls()) 
library(rstudioapi)
library(dplyr)
library(tidyverse)
library(GGally)
library(carData)
library(data.table)
library(ggplot2)
library(ggrepel)
library(factoextra)
library(pvclust)
library(cluster)
library(mclust)
library(dplyr)
library(NbClust)
current_path<-getActiveDocumentContext()$path
setwd(dirname(current_path))
hac<-read.csv("HappinessAlcoholConsumption.csv")

View(hac)
hac$Hemisphere <- str_replace(hac$Hemisphere, "noth", "north")
hac$Hemisphere <- str_replace(hac$Hemisphere, "both", "south")
hac<-hac[-c(6)]



hac$Region <- str_replace(hac$Region, "Australia and New Zealand", "ASIA")
hac$Region <- str_replace(hac$Region, "Eastern Asia", "ASIA")
hac$Region <- str_replace(hac$Region, "Southeastern Asia", "ASIA")

hac$Region <- str_replace(hac$Region, "Middle East and Northern Africa", "AFRICA")
hac$Region <- str_replace(hac$Region, "Sub-Saharan Africa", "AFRICA")

hac$Region <- str_replace(hac$Region, "Central and Eastern Europe", "EUROPA")
hac$Region <- str_replace(hac$Region, "Western Europe", "EUROPA")

hac$Region <- str_replace(hac$Region, "North America", "AMERICA")
hac$Region <- str_replace(hac$Region, "Latin America and Caribbean", "AMERICA")
#######cluster 
hac2 = hac[,-c(1,2,3)]

.rowNamesDF(hac, make.names=TRUE)<-as.vector(hac$Country)
.rowNamesDF(hac2, make.names=TRUE)<-as.vector(hac$Country)
hac_st<-scale(hac2)

dev.new()
boxplot(hac_st, xlab ="variabili", ylab="quantità")
boxplot(hac2, xlab ="variabili", ylab="quantità")

##DISTANZE
d1<-dist(hac2, method='euclidean')
summary(d1)
d<-dist(hac_st, method="euclidean")##meglio scalato
summary(d)

np=dim(hac_st)[1]
np

dev.new()
res=NbClust(hac_st, distance = "euclidean", min.nc=2, max.nc=11, method = "ward.D2", index = "all")
View(res)
View(res$Best.partition)

#DISTANZE CON L'ITALIA
sort(as.matrix(d)['Italy',])

dev.new()
dendro_ave = hclust(d,method='ward.D2')
plot(dendro_ave, main="Dendrogramma con 4 partizioni",labels=FALSE, xaxt="n", yaxt="n")
v=seq(from=1,to=(np-2), by=1)
taglio <-cutree(dendro_ave,k=4)
table(taglio)##numero individui in ogni gruppo
axis(1,v, labels=as.vector(hac$Country)[dendro_ave$order[v]],las=2,cex=0.07)
#abline(h=9, lty='dashed', col='blue')
rect.hclust(dendro_ave, k=4, taglio)#facciamo i quadrati dove tagliamo i grafici

##grafico con 3 partizioni
dev.new()
dendro_ave1 = hclust(d,method='ward.D2')
plot(dendro_ave1, main="Dendrogramma con 3 partizioni",labels=FALSE, xaxt="n", yaxt="n")
v=seq(from=1,to=(np-2), by=1)
taglio1 <-cutree(dendro_ave,k=3)
table(taglio1)##numero individui in ogni gruppo
axis(1,v, labels=as.vector(hac$Country)[dendro_ave1$order[v]],las=2,cex=0.07)
abline(h=15, lty='dashed', col='red')
rect.hclust(dendro_ave1, k=3, taglio1)#facciamo i quadrati dove tagliamo i grafici


dev.new()
plot(1:(np-1), dendro_ave$height, type ='b', xlab = 'Iterazione', ylab = 'distanza euclidea', main = 'happiness')#grafico delle distanze euclidee per tagliare meglio il grafico 
abline(h=9, lty='dashed', col='red')
abline(h=13, lty='dashed', col='blue')

g4<-cutree(dendro_ave, k = 4)# con k setti il numero di gruppi
g3<-cutree(dendro_ave, k = 3)# con k setti il numero di gruppi
g4
g3

centri4<-by(hac_st, g4, colMeans)##centroidi per ogni gruppo, la media deve essere fatta per gruppi. può essere fatta con il pipe operator. se analizzi bene ci sono i valori di deficit, debito, tasse, spesa ecc. puoi fare una analisi abbastanza approfondita su come sono strutturati i paesi all'interno dei gruppi
centri3<-by(hac_st, g3, colMeans)
centri3
centri4

#stampa i nomi dei gruppi
gruppi=rect.hclust(dendro_ave,k=4)
gruppi1=rect.hclust(dendro_ave1,k=3)


print(gruppi[[1]])
print(gruppi[[2]])
print(gruppi[[3]])
print(gruppi[[4]])

print(gruppi1[[1]])
print(gruppi1[[2]])
print(gruppi1[[3]])

summary(gruppi[[1]])
summary(gruppi[[2]])
summary(gruppi[[3]])
summary(gruppi[[4]])

summary(gruppi1[[1]])
summary(gruppi1[[2]])
summary(gruppi1[[3]])


##kmeans
###silhouette
dev.new()
fviz_nbclust(hac_st, kmeans, method = "silhouette") +  labs(subtitle = "Elbow method")+ geom_vline(xintercept = 2, linetype = 2)#per k-means

# valuta la misura di silhouette al variare del numero di gruppi
for(k in 2:3){
  dev.new()
  plot(silhouette(pam(hac_st, k=k)), main = paste("k = ",k), do.n.k=FALSE)
  mtext("PAM(hac_st) as in Kaufman & Rousseeuw, p.101",
        outer = TRUE, font = par("font.main"), cex = par("cex.main")); 
  Sys.sleep(2)
}

##3 gruppi; analizziamo la partizione
dev.new()
nrip=50
ng=3
km3=kmeans(hac_st, centers = ng, nstart=nrip)#centers è il numero dei gruppi
table(hac$Country, km3$cluster)
fviz_cluster(km3, hac_st)
##con 2 clusters(suggerito)
dev.new()
nrip=50
ng_opt=2
km2=kmeans(hac_st, centers = ng_opt, nstart=nrip)#centers è il numero dei gruppi
table(hac$Country, km2$cluster)
fviz_cluster(km2, hac_st)
###possiamo calcolare la CH per i tre gruppi prendendo il loop (ciclo for sopra) e sostituisci km a km3
##anche per l'R2

by(hac_st, km3$cluster, colMeans)#centroidi dei gruppi 
km3$size ##non ci sono elephant clusters perche hanno più o meno tutti la stessa dimensione
km3$withinss/km3$size#rapporto per vedere quanto si distanziano i vari gruppi tra di loro


by(hac_st, km2$cluster, colMeans)
km2$size 
km2$withinss/km2$size

#devianza within e between
print(km3$withinss)
print(km3$betweenss)

print(km2$withinss)
print(km2$betweenss)

#statistica descritiva dei gruppi per le variabili
aggregate(hac_st[,-1],by=list(km2$cluster),FUN=mean, na.rm=TRUE)
aggregate(hac_st[,-1],by=list(km3$cluster),FUN=mean, na.rm=TRUE)
###############################CON PCA

pc<-prcomp(hac2,scale=TRUE)

dev.new()
plot(pc$x[,1:3], pch=20, col=km3$cluster, xlab='CP1', ylab='CP2', main='Felicità')
text(pc$x[,1:3], labels=hac$Country, pos=1, cex=0.6)
abline(h=0, v=0, lty='dotted')
legend('bottomleft', pch=20, col=1:3, legend=c('G1', 'G2', 'G3'))
points(cp_centri3[,1:2], pch='*', cex=2, col=1:3)

dev.new()
plot(pc$x[,c(1,2)], pch=20, col=km2$cluster, xlab='CP1', ylab='CP2', main='Felicità')
text(pc$x[,c(1,2)], labels=hac$Country, pos=1, cex=0.6)
abline(h=0, v=0, lty='dotted')
legend('bottomleft', pch=20, col=1:3, legend=c('G1', 'G2'))
points(cp_centri3[,c(1,3)], pch='*', cex=2, col=1:3)


############PCA
#scree plot per analizzare il peso delle componenti principali (Nord America)
dev.new()
fviz_eig(pc)

dev.new()
biplot(pc, cex = 0.7)
abline(h=0)
abline(v=0)
pc$x #se utilizzo princomp pc$scores 
pc$rotation #sono i miei autovettori o loadings

library(factoextra)
dev.new()
fviz_pca_biplot(pc, repel = TRUE,
                col.var = "#FF5733", # Variables color
                col.ind = "696969"  # Individuals color
)

#rappresentazione di ogni valore(individuo) nel piano in base agli scores
dev.new()
disegno=data.frame(pc$x)
View(disegno)
p<-ggplot(disegno,aes(disegno[,1],disegno[,2]))+geom_label_repel(aes(label=row.names(hac)),size=2)
View(p)
p + ggtitle('Classificazione dei paesi') + xlab('PC1') + ylab('Felicità e sviluppo umano')

hac_2<-cbind(hac,pc$x[,1:2]) # aggiungo la prima e seconda cp a iris
View(hac_2)
cor(hac[,-c(1,2,3)],hac_2[,9:10])#vedo le correlazione tra pc e variabili mie non scalate

