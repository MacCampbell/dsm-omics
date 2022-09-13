#! /bin/bash
# Steps to QC and align samples, there are 133

## Executing in (base) maccamp@farm:~/Methylation/scripts$ 

## QC
sbatch -J fastqc.$USER --array=1-133 fastqc_pre.slurm;
sbatch -p high -J mqc.${USER} multiqc_pre.slurm;
sbatch -p high -J tg.${USER} --array=1-133 trimgalore.slurm;
jobid=$(sbatch -p high -J fqcp.${USER} --array=1-133 fastqc_post.slurm |cut -d' ' -f4 - )
sbatch -J mqcp.${USER} --dependency=afterok:${jobid} multiqc_post.slurm

## Align
sbatch -p high -J bm1.${USER} --array=1-133 bismark_part1.slurm