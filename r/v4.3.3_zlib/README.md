# RStudio server container (R v. 4.3.3) plus missing zlib

User found that RStudio container with R4.3.3 was missing zlib.h and was not able to install some packages. 

[This webpage](https://support.bioconductor.org/p/9140767/) describes the problem and the solution. The recipe file starts with the rocker/rstudio:4.3.3 image and the addition installation. 

### Notes
There still seems to be an error installing package `BiocManager` which wants to install packages `boot`, `codetools`, and `lattice`. If those installations are skipped, the installation will continue without error. More testing is needed to understand if those packages are required for downstream processed. Installing those packages individually outside of the `BiocManager` installation does not prevent the error. 