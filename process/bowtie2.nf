process Bowtie_removehost {

    tag "$meta"
	publishDir "${params.outputDir}/Bowtie_removehost/$meta/", mode: params.saveMode
    conda '/home/shafiha/miniconda3/envs/metgnome_pip'

	input:
    tuple val(meta), path(trimmed_reads)
    val type
    val state

    output:
    tuple val(meta), path("*_${state}.fastq.gz")   , emit: reads
    tuple val(meta), path('*.out'),        emit:bowtie2_out
    path("*.out")                ,        emit:bowtie2_human_removal

	script:
    """
	ls -lah
    bowtie2 \
        -p 8 \
        -x \
        --very-sensitive \
        -1 "${trimmed_reads[0]}" -2 "${trimmed_reads[1]}" \
        --un-conc-gz ${meta}_%_${state}.fastq.gz \
        -S /dev/null \
        2> ${meta}_${type}.out
    """
}