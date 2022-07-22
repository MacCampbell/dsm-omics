#! /bin/bash

# Basic script to generate Fst data
# Can execute with sbatch

# Usage
# 701.1-sfs.sh chromlist.txt

chromlist=$1

while read chrom; do
  echo "#!/bin/bash -l
realSFS outputs/701/hdi.saf.idx -r $chrom >  outputs/701/$chrom-hdi.sfs;
realSFS outputs/701/ldi.saf.idx -r $chrom >  outputs/701/$chrom-ldi.sfs;
realSFS outputs/701/hdi.saf.idx -r $chrom  outputs/701/ldi.saf.idx -r $chrom  > outputs/701/$chrom-hdi-ldi.2dsfs;
realSFS fst index  outputs/701/hdi.saf.idx  outputs/701/ldi.saf.idx -r $chrom -sfs outputs/701/$chrom-hdi-ldi.2dsfs -fstout outputs/701/$chrom-hdi-ldi;

# Global estimate
realSFS fst stats outputs/701/$chrom-hdi-ldi.fst.idx > outputs/701/$chrom-hdi-ldi.fst.stats;

# Sliding window

realSFS fst stats2  outputs/701/$chrom-hdi-ldi.fst.idx -win 50000 -step 10000 >  outputs/701/$chrom-sliding-window-50k-10k


 " > outputs/701/$chrom-fst.sh
  
sbatch -p bigmemm -t 24:00:00 --mem=16G --nodes=1 outputs/701/$chrom-fst.sh

done < $chromlist





