# UW Hyak Apptainer Images

Collection of Apptainer recipes (.def files) created for and by the UW Hyak user community. 


### 🧩 Contributing an Apptainer .def File

To make this repository useful for everyone, please follow this structure and checklist when adding a new container definition.

#### 📁 Directory Structure

Each container should live in its own directory by software name and version:

```bash
<software>/
└── <version>/
    ├── <software>.def
    ├── README.md
    └── [any scripts, example data, config files, etc.]
```

Example:

```bash
fsl/
└── v6.0.6-centos7/
    ├── fsl-centos7.def
    ├── README.md
    ├── fsl-centos7-array.slurm
    ├── fsl-centos7-single.slurm
    └── fslinstaller.py
```

#### ✅ Submission Checklist

Include all of the following:

1. Directory & File Naming
- [ ] Use a clear, lowercase name for the software (e.g., tensorflow, rstudio, samtools)
- [ ] Place the .def file inside a subdirectory named for the version (e.g., 2.13, 2023.12)
- [ ] Name the .def file descriptively (e.g., tensorflow-gpu.def, not container.def)

2. README.md
- [ ] Place a README.md in the same directory as the .def file. It must include:
- [ ] Title with the software and version
- [ ] Purpose of the container (brief, ~2–3 sentences)
- [ ] Build Instructions
    * Example:
```bash
    apptainer build tensorflow-gpu.sif tensorflow-gpu.def
```
- [ ] Run/Test Instructions
    * How to use the image
    * Example: launching scripts, shelling into the container, using GPU flags (`--nv`)
- [ ] Additional Resources Used
    * If your container depends on external files (like scripts or datasets), list them here.
    * Example : 
```bash
This container includes setup.sh for environment configuration.
Test data is provided in test_dataset.csv.
```

#### 📝 Required Comments in the .def File

Include this information in shell-style comments at the top of your .def file:
```bash 
# Image: <software>-<variant>.def
# Purpose: Brief explanation of the container’s function
# Author: Your Name (optional email)
# Build: apptainer build <image>.sif <def>.def
# Usage: apptainer exec [--nv] <image>.sif <command>
# Base image: docker://<base-image>
# Includes: List of major tools/packages installed
```

#### 🔒 Best Practices
- [ ] Pin software versions (e.g., pip install numpy==1.24.2)
- [ ] Clean up temp files (apt-get clean, rm -rf /var/lib/apt/lists/*)
- [ ] Use %labels and %help for discoverability
- [ ] Use relative paths and environment variables
- [ ] Test your build and basic usage before committing

