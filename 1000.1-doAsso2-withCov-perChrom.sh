#! /usr/bin/bash

# We can generate per chrom files with a loop like this to speed things up
# Feeding a list of chroms meta/test.chroms
# This will look for a covariance matrix named $chrom.cov based on the read in .chroms file.

# bash $HOME/dsm-omics/1000.1-doAsso2-withCov-perChr.sh $HOME/dsm-omics/bamlists/test91.bamlist  $HOME/dsm-omics/meta/1mbseqs.txt $HOME/dsm-omics/meta/test91.pheno 



bamlist=$1
list=$2
phenos=$3


#Setting minInd to 75% of inds
lines=$(wc -l < "$bamlist")
thresh=$((lines*.75))

while read chrom; do
  echo "#!/bin/bash -l
  $HOME/angsd/angsd -doAsso 2 -doPost 1 -yBin $phenos -cov $chrom.covariates -GL 1 -nThreads 12 -minInd $thresh  \
   -minMapQ 20 -minQ 20 -minMaf 0.05   -minHigh 20 \
  -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -r $chrom -out $chrom-asso \
  -bam $bamlist  > $chrom-asso.out 2> $chrom-asso.err " > $chrom-asso.sh
  
sbatch -p bigmemh -t 12:00:00 --mem=32G --nodes=1 $chrom-asso.sh

done < $list

#./angsd -doAsso 2 -bam bam.filelist -yQuant phenotypes.txt -cov new.covariats -out outfile_asso_test -GL 1 -doMaf 1 -doMajorMinor 1 -doPost 1 -SNP_pval 1e-6 -minMaf 0.05 -HWE_pval_F 0.05 -minInd 87 -minMapQ 20 -minQ 20
#-HWE_pval_F 0.05?
