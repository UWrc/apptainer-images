#!/bin/bash

#SBATCH --job-name=fsl-array

#SBATCH --account=uwit #optional change account
#SBATCH --partition=compute #change to ckpt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=30G
#SBATCH --time=10-00:00:00 # Max runtime in DD-HH:MM:SS format. Change to fit analysis.
#SBATCH --array=0-2 #this script sends an array of jobs (3)

#SBATCH --chdir=/gscratch/scrubbed/finchkn #change
#SBATCH --output=%x_%A_%a.o # file for STDOUT - generates file with job-name_job-id_SLURM_TASK_ID.o
#SBATCH --error=%x_%A_%a.e # file for STDERR goes

#author: finchnSNPs
#this is a SLURM template that can be used to run FSL on HYAK
#example usage:
#user provided a directory with MRI images from three subjects in three sub directories
#SLURM_TASK_ID index is applied to the subject ID
#bedpostx analysis multithreads itself to use all cpus provided with the SLURM directive --cpus-per-task

date
pwd

#load modules
module load apptainer

#set up SLURM index variable
SUBS=($(ls -1 /gscratch/scrubbed/finchkn/ADB))

SUBID=${SUBS[$SLURM_ARRAY_TASK_ID]}

#set sub-dir
DD=/gscratch/scrubbed/finchkn/ADB/$SUBID/

echo $SUBID
echo $DD

#execute
apptainer exec --bind /gscratch/ fsl-centos7.sif $FSLDIR/bin/bedpostx $DD/dwi/ -V

date
