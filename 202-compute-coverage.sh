#! /bin/bash 

#Create bedfile
# cut -f 1,2 Hyp_tra_F_20210204.fa.fai | awk -v OFS='\t' '{print $1, 0, $2}' > Hyp_tra_F_20210204.bed


## For existing data
#maccamp@farm:~/google/chinook_WGS_processed$ ls | grep rmdup | grep -v bai | perl -pe 's/.bam//g' > list.txt
#maccamp@farm:~/google/chinook_WGS_processed$ bash ~/shernook/102-compute-coverage.sh list.txt ../meta/GCF_002872995.1.bed


# samtools depth -a -b bedFileOfRegions -o outfile infile
# bedfile is meta/GCF_002872995.1.bed

# USAGE
# ../../202-compute-coverage.sh list.txt $HOME/genomes/hypomesus-20210204/Hyp_tra_F_20210204.bed

#For DSM
#(base) maccamp@farm:~/dsm-omics$ ls data/SOMM515/ | grep flt | grep -v bai | perl -pe 's/.bam//g' > data/SOMM515/list.txt
# ls data/SOMM516/ | grep flt | grep -v bai | perl -pe 's/.bam//g' > data/SOMM516/list.txt
# ls data/SOMM517/ | grep flt | grep -v bai | perl -pe 's/.bam//g' > data/SOMM517/list.txt

list=$1 
bedf=$2

#Say we are reading in something tab delimited.
IFS=$'\t'

while read name
do
   echo $name
   
  echo "#!/bin/bash -l
  samtools depth -a -b $bedf $name.bam | awk '{sum+="\$3"} END {print sum/NR}' > $name.cov" > $name-depth.sh
  sbatch -t 1:00:00 --mem=8G $name-depth.sh

done < $list

