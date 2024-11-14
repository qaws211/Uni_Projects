rm(list=ls())

library(rstudioapi)

current_path<-getActiveDocumentContext()$path
setwd(dirname(current_path))
library(GGally)
library(readxl)
library(carData)
library(data.table)
library(ggplot2)
library(ggrepel)
library(dplyr)
library(factoextra)
library(stringr)
library(olsrr)

## dataset

hac<-read.csv("HappinessAlcoholConsumption.csv")
View(hac)
hac$Hemisphere <- str_replace(hac$Hemisphere, "noth", "north")

str(hac)
View(head(hac))
View(tail(hac))

hac_st<-scale(hac[,-c(1,2,3,6)])# hac scalato e senza GDP poichè variabile fallata
View(hac_st)

hac_prova<-hac[,-c(1,2,3)]
View(hac_prova)

library(moments)
skewness(hac_prova)
kurtosis(hac_prova)


##hac_prova<-as.data.frame(hac_prova)
#ggplot(hac_prova, aes(x=reorder(Country, GDP_PerCapita), y=GDP_PerCapita, fill=Country)) + 
 # geom_bar(stat = "identity") +
  #ggtitle("Top 25 Paesi per GDP_Per_Capita") +
  #xlab("Country") +
  #ylab("GDP_Per_Capita") +
  #coord_flip() + 
  #theme(legend.position = "none")




      ### Analisi esplorativa ###


#pie plot
tab<-hac$Region%>%table()
percentages<-tab%>%prop.table()%>%round(3)*100
percentages
region_counts <- as.data.frame(table(hac$Region))
colnames(region_counts) <- c("Region", "Numbers")
View(region_counts)
txt<-paste0(names(tab), '\n', percentages,'%')
pie(tab, labels=txt)
#histogram
dev.new()
hac$Region%>%table()%>%barplot()
#abbelliamolo con i colori
bb<-hac$Region%>%table()%>%barplot(axisname=F, main="Region", ylab="frequency",
                                   col=c("pink","lightblue", "lightgreen"))
text(bb, tab/2, labels=txt, cex=1.06)

#correlations
cm1<-hac_st%>%as.matrix%>%cor()
cm2<-hac_corr%>%as.matrix%>%cor()
hac_corr<- scale(hac[,-c(1,2,3)])

library(ggcorrplot)
dev.new()
ggcorrplot(cm1)
dev.new()
ggcorrplot(cm2)

## grafici top e bottom 25 Paesi per ogni variabile

#HAPPINESS SCORE
hac_top25HS <- hac %>% 
  arrange(desc(HappinessScore)) %>% 
  slice(1:25)

dev.new()
ggplot(hac_top25HS, aes(x=reorder(Country, HappinessScore), y=HappinessScore, fill=Country)) + 
  geom_bar(stat = "identity") +
  ggtitle("Top 25 Paesi per HappinessScore") +
  xlab("Country") +
  ylab("HappinessScore") +
  coord_flip() + 
  theme(legend.position = "none")

hac_flop25HS <- hac %>% 
  arrange(desc(HappinessScore)) %>% 
  slice(97:122)

dev.new()
ggplot(hac_flop25HS, aes(x=reorder(Country, -HappinessScore), y=HappinessScore, fill=Country)) + 
  geom_bar(stat = "identity") +
  ggtitle("Flop 25 Paesi per HappinessScore") +
  xlab("Country") +
  ylab("HappinessScore") +
  coord_flip() + 
  theme(legend.position = "none")

#HDI
hac_top25HDI <- hac %>% 
  arrange(desc(HDI)) %>% 
  slice(1:25)

dev.new()
ggplot(hac_top25HDI, aes(x=reorder(Country, HDI), y=HDI, fill=Country)) + 
  geom_bar(stat = "identity") +
  ggtitle("Top 25 Paesi per HDI") +
  xlab("Country") +
  ylab("HDI") +
  coord_flip() + 
  theme(legend.position = "none")

hac_flop25HDI <- hac %>% 
  arrange(desc(HDI)) %>% 
  slice(97:122)

dev.new()
ggplot(hac_flop25HDI, aes(x=reorder(Country, -HDI), y=HDI, fill=Country)) + 
  geom_bar(stat = "identity") +
  ggtitle("Flop 25 Paesi per HDI") +
  xlab("Country") +
  ylab("HDI") +
  coord_flip() + 
  theme(legend.position = "none")

#GDP_PER_CAPITA
hac_top25GDP <- hac %>% 
  arrange(desc(GDP_PerCapita)) %>% 
  slice(1:25)

dev.new()
ggplot(hac_top25GDP, aes(x=reorder(Country, GDP_PerCapita), y=GDP_PerCapita, fill=Country)) + 
  geom_bar(stat = "identity") +
  ggtitle("Top 25 Paesi per GDP_Per_Capita") +
  xlab("Country") +
  ylab("GDP_Per_Capita") +
  coord_flip() + 
  theme(legend.position = "none")

hac_flop25GDP <- hac %>% 
  arrange(desc(GDP_PerCapita)) %>% 
  slice(97:122)

dev.new()
ggplot(hac_flop25GDP, aes(x=reorder(Country, -GDP_PerCapita), y=GDP_PerCapita, fill=Country)) + 
  geom_bar(stat = "identity") +
  ggtitle("Flop 25 Paesi per GDP_Per_Capita") +
  xlab("Country") +
  ylab("GDP_Per_Capita") +
  coord_flip() + 
  theme(legend.position = "none")

#BEER_PER_CAPITA
hac_top25BEER <- hac %>% 
  arrange(desc(Beer_PerCapita)) %>% 
  slice(1:25)

dev.new()
ggplot(hac_top25BEER, aes(x=reorder(Country, Beer_PerCapita), y=Beer_PerCapita, fill=Country)) + 
  geom_bar(stat = "identity") +
  ggtitle("Top 25 Paesi per Beer_Per_Capita") +
  xlab("Country") +
  ylab("Beer_Per_Capita") +
  coord_flip() + 
  theme(legend.position = "none")

hac_flop25BEER <- hac %>% 
  arrange(desc(Beer_PerCapita)) %>% 
  slice(97:122)

dev.new()
ggplot(hac_flop25BEER, aes(x=reorder(Country, -Beer_PerCapita), y=Beer_PerCapita, fill=Country)) + 
  geom_bar(stat = "identity") +
  ggtitle("Flop 25 Paesi per Beer_Per_Capita") +
  xlab("Country") +
  ylab("Beer_Per_Capita") +
  coord_flip() + 
  theme(legend.position = "none")

#WINE_PER_CAPITA
hac_top25WINE <- hac %>% 
  arrange(desc(Wine_PerCapita)) %>% 
  slice(1:25)

dev.new()
ggplot(hac_top25WINE, aes(x=reorder(Country, Wine_PerCapita), y=Wine_PerCapita, fill=Country)) + 
  geom_bar(stat = "identity") +
  ggtitle("Top 25 Paesi per Wine_Per_Capita") +
  xlab("Country") +
  ylab("Wine_Per_Capita") +
  coord_flip() + 
  theme(legend.position = "none")

hac_flop25WINE <- hac %>% 
  arrange(desc(Wine_PerCapita)) %>% 
  slice(97:122)

dev.new()
ggplot(hac_flop25WINE, aes(x=reorder(Country, -Wine_PerCapita), y=Wine_PerCapita, fill=Country)) + 
  geom_bar(stat = "identity") +
  ggtitle("Flop 25 Paesi per Wine_Per_Capita") +
  xlab("Country") +
  ylab("Wine_Per_Capita") +
  coord_flip() + 
  theme(legend.position = "none")

#SPIRIT_PER_CAPITA
hac_top25SPIRIT <- hac %>% 
  arrange(desc(Spirit_PerCapita)) %>% 
  slice(1:25)

dev.new()
ggplot(hac_top25SPIRIT, aes(x=reorder(Country, Spirit_PerCapita), y=Spirit_PerCapita, fill=Country)) + 
  geom_bar(stat = "identity") +
  ggtitle("Top 25 Paesi per Spirit_Per_Capita") +
  xlab("Country") +
  ylab("Spirit_Per_Capita") +
  coord_flip() + 
  theme(legend.position = "none")

hac_flop25SPIRIT <- hac %>% 
  arrange(desc(Spirit_PerCapita)) %>% 
  slice(97:122)

dev.new()
ggplot(hac_flop25SPIRIT, aes(x=reorder(Country, -Spirit_PerCapita), y=Spirit_PerCapita, fill=Country)) + 
  geom_bar(stat = "identity") +
  ggtitle("Flop 25 Paesi per Spirit_Per_Capita") +
  xlab("Country") +
  ylab("Spirit_Per_Capita") +
  coord_flip() + 
  theme(legend.position = "none")


## boxplot

boxplot(hac$HappinessScore)
boxplot(hac$HDI)
boxplot(hac$GDP_PerCapita)
boxplot(hac$Beer_PerCapita)
boxplot(hac$Spirit_PerCapita)
boxplot(hac$Wine_PerCapita)

# Impostazione della disposizione dei grafici
par(mfrow=c(2,3))

# Creazione dei boxplot
boxplot(hac$HappinessScore, main="Happiness Score")
boxplot(hac$HDI, main="HDI")
boxplot(hac$GDP_PerCapita, main="GDP per capita")
boxplot(hac$Beer_PerCapita, main="Beer per capita")
boxplot(hac$Spirit_PerCapita, main="Spirit per capita")
boxplot(hac$Wine_PerCapita, main="Wine per capita")

dev.new()
boxplot(hac_st, xlab = "variabili", ylab = 'quantità')


       ### Density plot ###
library(car)
dev.new()
par(mfrow=c(2,3))
densityPlot(hac$HappinessScore)
densityPlot(hac$HDI)
densityPlot(hac$GDP_PerCapita)
densityPlot(hac$Beer_PerCapita)
densityPlot(hac$Spirit_PerCapita)
densityPlot(hac$Wine_PerCapita)

#Density plot figo
df <- tibble(x_variable = rnorm(5000), y_variable = rnorm(5000))

ggplot(hac, aes(x = HDI, y = HappinessScore)) +
  stat_density2d(aes(fill = ..density..), contour = F, geom = 'tile')

ggplot(hac, aes(x = Beer_PerCapita, y = HappinessScore)) +
  stat_density2d(aes(fill = ..density..), contour = F, geom = 'tile')

ggplot(hac, aes(x = Wine_PerCapita, y = HappinessScore)) +
  stat_density2d(aes(fill = ..density..), contour = F, geom = 'tile')

ggplot(hac, aes(x = Spirit_PerCapita, y = HappinessScore)) +
  stat_density2d(aes(fill = ..density..), contour = F, geom = 'tile')

ggplot(hac, aes(x = GDP_PerCapita, y = HappinessScore)) +
  stat_density2d(aes(fill = ..density..), contour = F, geom = 'tile')

qqnorm(hac_st)



## Regressione lineare

hist(hac_st$HappinessScore)
hist(hac_st$HDI)
hist(hac_st$Beer_PerCapita)
hist(hac_st$Spirit_PerCapita)
hist(hac_st$Wine_PerCapita)

pairs(hac_st, pch = 18, col = "steelblue")

hac_st=as.data.frame(hac_st)

ggpairs(hac_st)

model_lm <- lm(HappinessScore ~. , data = hac_st)
summary(model_lm)

plot(model_lm)

hist(residuals(model_lm), col = "steelblue")
## qq_plot residuals
library(ggpubr)
ggqqplot(residuals(model_lm))

#qqplot
ols_plot_resid_qq(model_lm)

ols_test_normality(model_lm)

res <- resid(model_lm)
res
#grafico a campana dei residui
dev.new()
plot(density(res))


#create fitted value vs residual plot
dev.new()
plot(fitted(model_lm), residuals(model_lm))
#add horizontal line at 0
abline(h = 0, lty = 2)

library(car)

vif(model_lm)
ncvTest(model_lm) ## il modello è adatto per la descrizione dei dati e residui omoschedastici
plot(model_lm)

anova(model_lm) ## l'analisi mostra che HDI ha un effetto significativo su HappinessScore


## Test di normalità dei residui
shapiro.test(model_lm$residuals)  ## i dati sono distribuiti normalmente

library(lmtest)

## Test di omoschedasticità dei residui
bptest(model_lm)  ## non rifiutiamo l'ipotesi nulla

## Test di autocorrelazione dei residui
dwtest(model_lm)   ## autocorrelazione positiva

AIC(model_lm) ## buon bilanciamento tra bontà del modello e complessità
BIC(model_lm)
RMSE <- sqrt(mean(residuals(model_lm)^2))
RMSE  ## può essere considerato un buon livello di precisione del modello.


## grafici regressione lineare
library(ggplot2)

dev.new()
ggplot(hac_st, aes(x=HDI, y=HappinessScore)) + 
  geom_point() +
  geom_smooth(method="lm", formula=HappinessScore ~ HDI + Beer_PerCapita + Wine_PerCapita + Spirit_PerCapita, se=FALSE) +
  labs(title="Grafico a dispersione dei dati", x="HDI", y="Happiness Score")

# caricamento del pacchetto scatterplot3d
library(scatterplot3d)

# creazione del grafico a dispersione 3D con superficie di regressione lineare
dev.new()
scatterplot3d(hac_st$HDI, hac_st$Beer_PerCapita, hac_st$HappinessScore, 
              xlab = "HDI", ylab = "BeerPerCapita", zlab = "HappinessScore",
              type = "p", color = "red",
              main = "Regressione lineare 3D")

# aggiunta della superficie di regressione lineare
fit <- lm(HappinessScore ~ HDI + Beer_PerCapita, data = hac_st)
s3d <- scatterplot3d(hac_st$HDI, hac_st$Beer_PerCapita, hac_st$HappinessScore, 
                     type = "p", color = "red",
                     main = "Regressione lineare 3D")
s3d$plane3d(fit)

















































