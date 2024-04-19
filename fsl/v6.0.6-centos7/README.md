# UW HYAK FSL container

FMRIB Software Library container recipe and SLURM job submission script examples. 

Created at the request of UW HYAK users in March 2024. 

### About FMRIB Software Library (FSL)

 [FSL Wiki](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FSL)

 ### Versions

 OS = Centos7 
 
 `fslinstaller.py` version number 3.2.0 - The version in this repo contains one change to fix a ca.certificates error. There are lines in the apptainer recipe file to download `fslinstaller.py` from the [FSL Wiki](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FSL). Un-comment lines to use that install, and `#comment lines to install from this GitHub repo.` 

 Installs `FSL` version 6.0.6 .

 Includes the [fsl-sub-plugin-slurm](https://git.fmrib.ox.ac.uk/fsl/fsl_sub_plugin_slurm) for integration with `SLURM`. 

 ### Apptainer recipe file

The `apptainer` recipe file `fsl-centos7.def` was from a template originally created by Tashrif Billah found in this [repo](https://github.com/pnlbwh/fsl-containers/tree/master) and the file named [Singularity.centos7](https://github.com/pnlbwh/fsl-containers/blob/master/Singularity.centos7).

Build the `apptainer` container. On HYAK, load the `apptainer` module with `module load apptainer` from an [interactive job](https://hyak.uw.edu/docs/compute/scheduling-jobs#interactive-node-partitions).

```shell terminal=true
$ apptainer build fsl-centos7.sif fsl-centos7.def
```

Test the container.

```shell terminal=true
$ apptainer shell --bind /gscratch/ fsl-centos7.sif
Apptainer> echo $FSLDIR
/fsl-centos7

Apptainer> fsl_sub
usage: fsl_sub [-h] [-a ARCH] [-c COPROCESSOR]
               [--coprocessor_multi COPROCESSOR_MULTI]
               [--coprocessor_class COPROCESSOR_CLASS]
               [--coprocessor_class_strict]
               [--coprocessor_toolkit COPROCESSOR_TOOLKIT] [-F] [-j JOBHOLD]
               [--not_requeueable] [--array_hold ARRAY_HOLD] [-l LOGDIR]
               [-m MAILOPTIONS] [-M MAILTO] [-n] [-N NAME] [-p PRIORITY]
               [-q QUEUE] [-r RESOURCE] [--delete_job DELETE_JOB]
               [--extra EXTRA] [-R GB] [-s PARALLELENV,THREADS]
               [-t ARRAY_TASK] [--array_native ARRAY_NATIVE] [-x NUMBER]
               [--keep_jobscript] [--has_coprocessor COPROCESSOR_NAME]
               [--has_queues] [--project PROJECT] [-S] [-T MINUTES]
               [--show_config] [-v] [-V] [-z file]
               ...
fsl_sub: error: No command or array task file provided

Apptainer> which python
/fsl-centos7/bin/python
```

### SLURM scripts

`SLURM` scripts provided for sending array and single jobs to HYAK.

Send job/s to SLURM job scheduler with `sbatch`. 

```shell terminal=true
$ sbatch fsl-centos7-array.slurm
```

Monitor job/s with `squeue` and your `UWNetID`.

```shell terminal=true
$ squeue -u <UWNetID>
```

Cancel job/s with `scancel` and the `JOBID`.

```shell terminal=true
$ scancel <JOBID>
```