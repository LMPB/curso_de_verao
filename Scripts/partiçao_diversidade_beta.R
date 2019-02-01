#Script produzido para o curso R para dados biológicos
#V curso de verão - PPG-ERN
#28-01-2019 a 01-02-2019
#Responsáveis: Erick Barros & Pedro Junger

#Análise: Partição da Diversidade-Beta

library(betapart)
library(vegan)
setwd("C:/Seu-local-de-armazenamento-de-dados")
otu=read.table(file="dados-biológicos.txt", header=T, row.names=1, sep="\t", dec=".", na.strings="NA")

#este indice exige uma tabela da dados em formato "presença-ausência"
otu=decostand(otu, "pa")

#os dados biológicos devem conter espécies como colunas e sítios como linhas
otu=t(otu)

#é possivel realizar o teste com os dados totais e com uma matriz de distâncias. 
#O resultado final será o mesmo
#dist.matrix=betapart.core(otu)
beta.pair=beta.pair(dist.matrix, index.family = "sorensen")

#Os dados são armazenados como valores para matrizes
#Para transformar em tabelas de dados
dissimilarity <- data.frame(t(combn(rownames(otu),2)), as.numeric(beta.pair$beta.sor))
names(dissimilarity) <- c("S1", "S2", "dissimilarity")

nestedness <- data.frame(t(combn(rownames(otu),2)), as.numeric(beta.pair$beta.sne))
names(nestedness) <- c("S1", "S2", "nestedness")

turnover <- data.frame(t(combn(rownames(otu),2)), as.numeric(beta.pair$beta.sim))
names(turnover) <- c("S1", "S2", "turnover")

#juntar todos os dados obtidos em uma unica tabela
results=cbind(dissimilarity,nestedness$nestedness,turnover$turnover)
colnames(results)[4] <- "nestedness"
colnames(results)[5] <- "turnover"

#salvar tabela como arquivo txt
write.table(results,"beta_part.txt")

