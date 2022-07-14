#! /bin/bash

# Basic script to generate Fst data
# Can execute with srun 

realSFS outputs/701/hdi.saf.idx >  outputs/701/hdi.sfs;
realSFS outputs/701/ldi.saf.idx >  outputs/701/ldi.sfs;
realSFS outputs/701/hdi.saf.idx outputs/701/ldi.saf.idx > outputs/701/hdi-ldi.2dsfs;
realSFS fst index  outputs/701/hdi.saf.idx  outputs/701/ldi.saf.idx -sfs outputs/701/hdi-ldi.2dsfs -fstout outputs/701/hdi-ldi;

# Global estimate
realSFS fst stats outputs/701/hdi-ldi.fst.idx > outputs/701/hdi-ldi.fst.stats;

# Sliding window

realSFS fst stats2  outputs/701/hdi-ldi.fst.idx -win 50000 -step 10000 >  outputs/701/sliding-window-50k-10k
