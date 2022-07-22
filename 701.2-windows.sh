#! /bin/bash

# Creating windows of different sizes after running 701.1

# Usage
# 701.2-windows.sh chromlist.txt
# 701.2-windows.sh meta/1mbseqs.txt

chromlist=$1

while read chrom; do
  echo "#!/bin/bash -l
realSFS fst stats2  outputs/701/$chrom-hdi-ldi.fst.idx -win 25000 -step 5000 >  outputs/701/$chrom-sliding-window-25k-5k
realSFS fst stats2  outputs/701/$chrom-hdi-ldi.fst.idx -win 12500 -step 2500 >  outputs/701/$chrom-sliding-window-12.5k-2.5k

 " > outputs/701/$chrom-windows.sh
  
sbatch -p bigmemm -t 24:00:00 --mem=16G --nodes=1 outputs/701/$chrom-windows.sh

done < $chromlist

