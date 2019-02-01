#Script produzido para o curso R para dados biológicos
#V curso de verão - PPG-ERN
#28-01-2019 a 01-02-2019
#Responsáveis: Erick Barros & Pedro Junger

#Análise: PCA

library(vegan)
library(ggplot2)
require(ggbiplot)
library(dplyr)
setwd("C:/Seu-local-de-armazenamento-de-dados")

#Criando 
amb=read.table(file="dados-ambientais.txt", header=TRUE, row.names = 1, dec = ".")

p= amb[,4:25] %>% 
    as.data.frame() %>% 
    decostand(na.rm=T, method="standardize") %>% 
    prcomp()

#PCA
amb$trophic <- factor(amb$trofia, levels = c("oligo", "meso", "eu")) #ordena nessa ordem na legenda
ggbiplot(p, labels =  rownames(amb$trofia), obs.scale = 1, 
           var.scale=1,groups=amb$trofia,ellipse=F,circle=F)+
  scale_shape_manual(name = "Bacia", labels = c("oligo", "meso", "eu"), values = c(21, 21, 21, 21)) +
  scale_colour_manual(name = "Bacia", labels = c("oligo", "meso", "eu"), values = c("green","blue", "red"))+
  theme_classic()
  

ggbiplot(p, labels =  rownames(amb$bacia), obs.scale = 1, 
           var.scale=1,groups=amb$bacia,ellipse=F,circle=F)+
  scale_shape_manual(name = "Bacia", labels = c("Grande", "Paranapanema", "Serra do mar", "Tiete"), values = c(21, 21, 21, 21)) +
  scale_colour_manual(name = "Bacia", labels = c("Grande", "Paranapanema", "Serra do mar", "Tiete"), values = c("orange","red", "blue", "green"))+
  theme_bw()
  