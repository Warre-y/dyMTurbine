#! /bin/bash
#
#SBATCH --job-name=dyMTurbine_v01_7_full
#SBATCH --partition=zen5_mpi
#SBATCH --ntasks-per-node=8
#SBATCH --mem=10G
#SBATCH --time=2:00:00
#SBATCH --output=log.%j
#SBATCH --error=err.%j

# Build the environment
module --force purge
module load OpenFOAM/v2406-foss-2023a
source $FOAM_BASH

# Go to the directory from where the job was submitted
#cd $VSC_SCRATCH/MArun_scratch/

chmod +x ./runCase.sh

# Execute the script
./runCase.sh

# PostProcess Plot flow velocity 
#module load SciPy-bundle/2023.07-gfbf-2023a  
#module load matplotlib/3.7.2-gfbf-2023a  
#python3 probeDataPlot.py
