process Fastp {

	tag "$meta"
	publishDir "${params.outputDir}/Fastp/$meta", mode: params.saveMode
    conda '/home/shafiha/miniconda3/envs/metgnome_pip'

	input:
	tuple val(meta), path(reads)

    output:
    tuple val(meta), path("*.trim.fastq.gz"), emit: trimmed_reads_ch
    tuple val(meta), path("*.json")           , emit: json
    tuple val(meta), path("*.html")           , emit: html
    path("*.json") , emit: fastp_json

	script:
    """
    fastp \\
        --thread ${params.fastp_threads} \\
        --in1 ${reads[0]} \\
        --in2 ${reads[1]} \\
        --detect_adapter_for_pe \\
        --out1 ${meta}_1.trim.fastq.gz \\
        --out2 ${meta}_2.trim.fastq.gz \\
        --json ${meta}.fastp.json \\
        --html ${meta}.fastp.html \\
        2> ${meta}.fastp.log
    """
}