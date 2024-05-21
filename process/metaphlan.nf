process Metaphlan {

    tag "$meta"
	publishDir "${params.outputDir}/Metaphlan/$meta/", mode: params.saveMode
    conda '/home/shafiha/miniconda3/envs/metaphlan'

	input:
    tuple val(meta), path(trimmed_reads)
    path db

    output:
    tuple val(meta), path('*'),        emit:metaph_output

	script:
    """
    metaphlan "${trimmed_reads[0]}","${trimmed_reads[1]}"\
        --input_type fasta \
        -- ${db}\
        > ${meta}_metaphlan.txt
    """
}