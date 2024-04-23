#!/bin/bash
#SBATCH --job-name=star-array
#SBATCH --mail-user=<UWNetID>@uw.edu
#SBATCH --mail-type=END
#SBATCH --account=uwit
#SBATCH --partition=ckpt
#SBATCH --nodes=1
#SBATCH --cpus-per-task=12 #becomes SLURM environment variable SLURM_CPUS_ON_NODE passed to --runThreadN
#SBATCH --mem=60G
#SBATCH --time=0-06:00:00 #add maximum time limit to align all samples in the array
#SBATCH --array=0-71 #0-based numbering for the samples in the array, becomes SLURM environment variable SLURM_ARRAY_TASK_ID index
#SBATCH -o %x_%A_%a.o # STDOUT - generates file with job-name_job-id_SLURM_TASK_ID.o
#SBATCH -e %x_%A_%a.e # STDERR - generates file with job-name_job-id_SLURM_TASK_ID.e

#load module apptainer to use a container 
module load apptainer

#open the directory with your files to process
cd /path/to/fastq/input/files

#use a list of sample IDs that will become your list for this array of jobs
#see https://github.com/UWrc/apptainer-images/blob/master/STAR/v2.7.11b/README.md for more information
SAMPS=($(cat samplelist.txt))

#assign an index to your sample IDs
SAMP=${SAMPS[$SLURM_ARRAY_TASK_ID]}

#this will print the sample ID for each job to the STDOUT for each array job
echo $SAMP

#NOTE the following command requires an indexed reference genome. 
#See https://github.com/UWrc/apptainer-images/blob/master/STAR/v2.7.11b/README.md for template code to generate. 

#main code line here
apptainer exec --bind /gscratch/ STAR_aligner.sif STAR --runThreadN ${SLURM_CPUS_ON_NODE} --genomeDir /path/to/genomeDir --runMode alignReads --readFilesIn ${SAMP}.1.fastq.gz ${SAMP}.2.fastq.gz --readFilesCommand zcat --outFileNamePrefix /path/to/bams output/${SAMP} --twopassMode Basic --outSAMtype BAM Unsorted