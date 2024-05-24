# Nextflow_metagenome_pipeline

The following Nextflow pipeline was developed to create results of the predicted microbial clades present in the metagenomic samples. The input is metagenomic shot gun sequencing data and the output would be a file containing the counts of the classes thats present in the input sample.

It consist of the following process :
1. Quality control : Fastp
2. Remove host : Bowtie2
3. Identify the species present : MetaPhlAn

## Steps to run the pipeline 

1. Copy the Github repository locally.
2. Create the conda environemnt with the required tools and change the line that starts with conda in each process to the path where you have installed the tools.
3. Install your preferred host and change the line 15 in main.nf to the host which you require to be removed.
4. In main.nf line 21 contains the path to metaphlan database which should be install on the users end as well and this path should be changed too.
5. On your command line within the Nextflow_metagenome_pipeline folder , type nextflow run main.nf to run the pipeline.

Note: If any parameters has to be changed , it could be changed in the process folder as the tools that are required to run the pipeline are within this folder.

