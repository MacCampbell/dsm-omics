
#Basic steps to generate PCS
#cov <- as.matrix(read.table("NC_061085.1.cov"))
#e<-eigen(cov)
#write.table(e$vectors[,1:3],file="NC_061085.1.covariates",row=F,qu=F,col=F)

#Need to generalize.
#/home/maccamp/miniconda2/bin/Rscript on FARM

# 1. Read in file of chroms

files<-read.table("meta/1mbseqs.txt", col.names = c("Chrom"), sep="\t")
  
# 2. look for output in dir (1300)

# 3. Generate covariates
covariates<-function(file) {
  #chrom<-gsub(".cov","",file)
  cov <- as.matrix(read.table(paste0("outputs/1300/",file,".cov")))
  e<-eigen(cov)
  
  write.table(e$vectors[,1:3],file=paste0("outputs/1300/",file,".covariates"),row=F,qu=F,col=F)
  
}

lapply(files$Chrom, covariates)




