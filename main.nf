//  Metagenome pipeline
// 
nextflow.enable.dsl=2
//parameters to change 

params.saveMode = 'copy'
params.metadata = "$projectDir/"
params.inputDir = "$projectDir/input_data/"
params.outputDir        = "$projectDir/pipeline-output/"
params.workDir          = "$projectDir/work/"
params.runType = 'execution'


//parameters to consider 
host = file('/home/shafiha/metgenome_resources/host/GRCh38_noalt_as')
d2 = []
host.eachFile {d2 << it}
Channel.from(d2).set{host_file}

//metaphlan db (path to mtaphlan db)
metaphlan_db = path('/home/shafiha/metaphlan_db')
//d3 = []
//metaphlan.eachFile {d3 << it}
//Channel.from(d3).set{metaphlan_db}


log.info """\
         Metagenome pipeline
         =============================
         Inputs: ${params.inputDir}
         Outputs: ${params.outputDir}
         WorkDir: ${params.workDir}
         """
         .stripIndent()



include { Fastp } from './process/fastp'
include { Bowtie_removehost } from './process/bowtie2'
include { Metaphlan } from './process/metaphlan'


workflow {
    
    reads_ch = Channel.fromFilePairs("${params.inputDir}/**/" + '*_{1,2}.*.gz', size: -1, maxDepth: 1)
    input = Channel.fromPath(params.inputDir, checkIfExists: true)

    reads_ch.view()
    
    Fastp(reads_ch )
    state_ch = Channel.value('unmapped')
    type_ch = Channel.value('host_removal')

    Bowtie_removehost( Fastp.out.trimmed_reads, type_ch, state_ch ,host_file.collect())
    Metaphlan( Fastp.out.trimmed_reads,metaphlan_db.collect())


}

workflow.onComplete {
    log.info ( workflow.success ? "Completed!" : "Error" )
}