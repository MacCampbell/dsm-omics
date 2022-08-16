

#Basic steps to automate
cov <- as.matrix(read.table("NC_061085.1.cov"))
e<-eigen(cov)
write.table(e$vectors[,1:3],file="NC_061085.1.covariates",row=F,qu=F,col=F)



