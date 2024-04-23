# UW HYAK STAR container

See [**STAR repo by Alex Dobin**](https://github.com/alexdobin/STAR.git) for more details and the manual for using STAR. 

To provide a version of STAR for HYAK users, I converted the [**Dockerfile**](https://github.com/alexdobin/STAR/blob/master/extras/docker/Dockerfile) provided by Dobin into an `apptainer` .def file. The changes were minor. The only addition that was required was to install `vim-common` and all of its dependencies to have `xxd` which is required for building STAR. 

### Building the STAR container

Download the `STAR_aligner.def` file from this repo. 

```bash
$ wget https://github.com/UWrc/apptainer-images/blob/master/STAR/v2.7.11b/STAR_aligner.def
```

Build the `apptainer` container. On HYAK, load the `apptainer` module with `module load apptainer` from an [**interactive job**](https://hyak.uw.edu/docs/compute/scheduling-jobs#interactive-node-partitions).

```bash
$ apptainer build STAR_aligner.sif STAR_aligner.def
```

Test the container.

```bash
$ apptainer run STAR_aligner.sif STAR -h
$ apptainer run STAR_aligner.sif STAR --version
```

### Run with SLURM array script

STAR requires an indexed reference genome. The following is an example command to meet with requirements. 

```bash
$ apptainer exec --bind /gscratch STAR_aligner.sif STAR --runThreadN 32 --runMode genomeGenerate --genomeDir /path/to/genomeDir --genomeFastaFiles /path/to/reference_genome.fasta --sjdbGTFfile /path/to/GTF/reference_genome_assembly.annotation.gtf --sjdbOverhang 100
```

- `--runThreadN` should match the number of CPUs requested for the interactive or batch job (`--cpus-per-task`).
- `--sjdbOverhang` will vary depending on rna-seq data (read length - 1).

Download the SLURM array script `STAR-array.slurm` template from this repo. 

```bash
$ wget https://github.com/UWrc/apptainer-images/blob/master/STAR/v2.7.11b/STAR-array.slurm
```

Adjust the script as needed. Launch the jobs array with `sbatch`. 

```bash
$ sbatch STAR-array.slurm
```

Monitor the jobs with `squeue` and your UWNetID like the following example.

```bash
$ squeue -u <UWNetID>
```

### Contributors 

- Dr. Rayan Najjar (@R-Najjar) contributed the SLURM array sbatch script that became `STAR-array.slurm` and the template command for generating the indexed reference genome. 

