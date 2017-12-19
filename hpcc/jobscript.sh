#!/bin/bash

module use /opt/software/ged-software/modulefiles/
module load anaconda
module unload python
module swap GNU GNU/6.2
source activate snakemake 

{exec_job}

