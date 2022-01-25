#! /usr/bin/bash

# We can generate per chrom files with a loop like this to speed things up
# Feeding a list of chroms meta/test.chroms
# bash $HOME/shernook/201-parallelize-analyses.sh $HOME/shernook/bamlists/bamlist56.bamlist $HOME/shernook/meta/test.chroms


bamlist=$1
list=$2

#Setting minInd to 3/4 of inds
lines=$(wc -l < "$bamlist")
thresh=$((3*lines/4))

while read chrom; do
  echo "#!/bin/bash -l
  $HOME/angsd/angsd -nThreads 6 -minInd $thresh -GL 1 \
-doGlf 2  -doMajorMinor 1 -doMaf 2 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 \
-r $chrom -out $chrom-pca -minMaf 0.05 -postCutoff 0.90 \
-bam $bamlist > $chrom.out 2> $chrom.err " > $chrom.sh
  
sbatch -p bigmemm -t 12:00:00 --mem=32G --nodes=1 $chrom.sh

done < $list
