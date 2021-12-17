# dsm-omics
Organization and analysis of Delta Smelt omics data

## Types of data

__1__ WGS
__2__ RNAseq
__3__ rrBS

## End point

The final disposition should be on SRA, with that number linked to the data here.

__1__ WGS     

Description	NovaSeq S4 300 (PE150)     


Downloading to barbera:/share/schreierlab/smelt-wgs

srun -p production -t 1-01:00:00 wget -nH -r -np http://slimsdata.genomecenter.ucdavis.edu/Data/r2ro9m3i97/Un_DTSA406/Project_AFSR_SOMM515/

srun -p production -t 1-01:00:00 wget -nH -r -np http://slimsdata.genomecenter.ucdavis.edu/Data/yunmj7ebr6/Un_DTSA407/Project_AFSR_SOMM516/

srun -p production -t 1-01:00:00 wget -nH -r -np http://slimsdata.genomecenter.ucdavis.edu/Data/hr9viovcfo/Un_DTSA408/Project_AFSR_SOMM517/


Demultiplexing     

fastq-multx -B barcodes.tsv -m 0 \
    Undetermined_S0_L001_I1_001.fastq.gz \
    Undetermined_S0_L001_I2_001.fastq.gz \
    Undetermined_S0_L001_R1_001.fastq.gz \
    Undetermined_S0_L001_R2_001.fastq.gz \
    -o n/a -o n/a -o %_R1.fastq -o %_R2.fastq
    
Where barcodes.tsv looks like:    
id      seq     style
D708_508        TAATGCGC-GTACTGAC       TruSeq
D709_501        CGGCTATG-TATAGCCT       TruSeq
D709_502        CGGCTATG-ATAGAGGC       TruSeq

Create list of indices:


/home/maccampbell/smelt-wgs/test-raw
maccampbell@barbera:~/smelt-wgs/test-raw$ gunzip -c ../SOMM517_S1_L003_I1_001.fastq.gz | head -n 400000 > I1.fastq
maccampbell@barbera:~/smelt-wgs/test-raw$ gunzip -c ../SOMM517_S1_L003_I2_001.fastq.gz | head -n 400000 > I2.fastq

paste I1.fastq I2.fastq  | grep "^A\|G\|C\|T" | perl -pe 's/\t/-/' | sort | uniq        

maccampbell@barbera:~/smelt-wgs/test-raw$ gunzip -c ../SOMM515_S1_L001_I1_001.fastq.gz | head -n 400000 > 15I1.fastq
maccampbell@barbera:~/smelt-wgs/test-raw$ gunzip -c ../SOMM515_S1_L001_I2_001.fastq.gz | head -n 400000 > 15I2.fastq
maccampbell@barbera:~/smelt-wgs/test-raw$ paste 15I1.fastq 15I2.fastq  | grep "^A\|G\|C\|T" | perl -pe 's/\t/-/' | sort | uniq -c | sort -nr -k1 | head -n 150 > top15 


