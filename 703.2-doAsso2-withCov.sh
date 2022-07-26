#! /usr/bin/bash

# We can generate per chrom files with a loop like this to speed things up
# Feeding a list of chroms meta/test.chroms

# bash $HOME/dsm-omics/703.1-gwas-with-cov.sh $HOME/dsm-omics/bamlists/test91.bamlist  $HOME/dsm-omics/meta/1mbseqs.txt $HOME/dsm-omics/meta/test91.pheno $HOME/dsm-omics/outputs/601/test96-kinremoved.cov


bamlist=$1
list=$2
phenos=$3
cov=$4

#Setting minInd to 1/2 of inds
lines=$(wc -l < "$bamlist")
thresh=$((lines/2))

while read chrom; do
  echo "#!/bin/bash -l
  $HOME/angsd/angsd -doAsso 2 -doPost 1 -yBin $phenos -cov $cov -GL 1 -nThreads 12 -minInd $thresh  \
   -minMapQ 20 -minQ 20 -minMaf 0.05 \
  -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -r $chrom -out $chrom-asso \
  -bam $bamlist  > $chrom-asso.out 2> $chrom-asso.err " > $chrom-asso.sh
  
sbatch -p bigmemm -t 12:00:00 --mem=32G --nodes=2 $chrom-asso.sh

done < $list


