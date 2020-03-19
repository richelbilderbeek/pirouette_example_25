#!/bin/bash
#
# Re-run the code locally, to re-create the data and figure.
#
# Usage:
#
#   ./scripts/rerun.sh
#
#SBATCH --partition=gelifes
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=10G
#SBATCH --job-name=pirex25
#SBATCH --output=example_25.log
#
rm -rf example_25
rm *.png
time Rscript example_25.R
zip -r pirouette_example_25.zip example_25 example_25.R scripts *.png

