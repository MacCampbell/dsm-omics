#! /bin/bash
# Steps to QC and align samples, there are 133

## Executing in (base) maccamp@farm:~/Methylation/scripts$ 

## QC
sbatch -p bigmemm -J fastqc.$USER --array=1-133 fastqc_pre.slurm; #running
sbatch -p high -J mqc.${USER} multiqc_pre.slurm;
sbatch -p bigmemm -J tg.${USER} --array=1-133 trimgalore.slurm;
jobid=$(sbatch -p bigmemm -J fqcp.${USER} --array=1-133 fastqc_post.slurm |cut -d' ' -f4 - )
sbatch -J mqcp.${USER} --dependency=afterok:${jobid} multiqc_post.slurm

## Align
sbatch -p bigmem -J bm1.${USER} --array=1-133 bismark_part1.slurm