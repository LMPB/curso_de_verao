#Script produzido para o curso R para dados biológicos
#V curso de verão - PPG-ERN
#28-01-2019 a 01-02-2019
#Responsáveis: Erick Barros & Pedro Junger

#Análise: Mantel test

library(vegan)
setwd("C:/Seu-local-de-armazenamento-de-dados")

#Criando 
amb=read.table(file="dados-ambientais.txt", header=TRUE, row.names = 1, dec = ".")
geo=read.table(file="dados-geograficos.txt", header=T, row.names=1, dec=".")
otu<-read.table(file="dados-biológicos.txt", header=T, row.names=1, sep="\t", dec=".", na.strings="NA")

#caso seja de interesse transformar os dados em abundância relativa
otu=decostand(otu, method ="total", MARGIN = 2)

#os dados biológicos devem conter espécies como colunas e sítios como linhas
otu=t(otu)

#criar matriz de distâncias para dados ambientais
dist.amb=vegdist(amb[,4], method="euclidean") #é possivel também utilizar a forma amb$coluna-de-interesse
#para visualizar o resultado é preciso transformar a matriz de distâncias para matriz
#dist.amb.visualizar=as.matrix(dist.amb) 

#criar matriz de distância para dados geográficos
library(fields)
dist.geo=rdist.earth(geo,geo, miles = FALSE)
rownames(dist.geo)=rownames(geo)
colnames(dist.geo)=rownames(geo)

dist.geo[upper.tri(dist.geo, diag=TRUE)]<-""
dist.geo=as.dist(dist.geo)

#criar matriz de distâncias para dados biológicos
dist.abund <- vegdist(otu, method="bray")

mantel(dist.abund, dist.matrix, method="spear")
