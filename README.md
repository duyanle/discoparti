# Defining Molecular Signatures of Autoimmunity in Type 1 Diabetes with DisCo ParTI 

This is a repo detailing analysis done for a 20.440 Spring 2025 final. Read below for description of repo contents and instructions for replicating analysis.

## For PS6:
1. The repo is mainly organized in two folders: data and code.

2. Data contains only 1 .h5ad file. 

3. Code contains only 1 R script. 

### Data: 
Data was obtained from [Synapse](https://www.synapse.org/Synapse:syn53641849) under accession code syn53641849. [1]

This file contains scRNAseq data from PBMCs of 46 Type 1 Diabetes patients and 31 healthy, matched controls. 

Count matrix is provided in the repo due to the full file being too large to upload to GitHub. 

### Code: 

Below is a running list of scripts included in the code folder: 

#### 1. PCAloadings.R
The following packages are required to run:
 - Seurat (5.2.1)
 - tidyverse (2.0.0)
 - schard (0.0.1)

### Installation: 
The R script(s) provided run(s) on R (4.3.3) in R-studio (2024.12.1+563) 

See code section for specific packages required in each script. 

### Citations: 
 [1] Honardoost, M.A., Adinatha, A., Schmidt, F. et al. Systematic immune cell dysregulation and molecular subtypes revealed by single-cell RNA-seq of subjects with type 1 diabetes. Genome Med 16, 45 (2024). https://doi.org/10.1186/s13073-024-01300-z
