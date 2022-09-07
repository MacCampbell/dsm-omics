
#Basic steps to generate PCS
#cov <- as.matrix(read.table("NC_061085.1.cov"))
#e<-eigen(cov)
#write.table(e$vectors[,1:3],file="NC_061085.1.covariates",row=F,qu=F,col=F)

#Need to generalize.
#/home/maccamp/miniconda2/bin/Rscript on FARM
library(tidyverse)

# 1. Read in file of chroms

files<-read_tsv("$HOME/dsm-omics/meta/test-chrom.txt", col_names=c("Chrom"))
  
# 2. look for output in dir (1000)

# 3. Generate covariates
covariates<-function(file) {
  chrom<-gsub(".cov","",file)
  cov <- as.matrix(read.table(paste0("outputs/1000",file,".cov")))
  e<-eigen(cov)
  
  write.table(e$vectors[,1:3],file=paste0("outputs/1000",chrom,".covariates"),row=F,qu=F,col=F)
  
}

lapply(files, covariates)




