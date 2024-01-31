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


log.info """\
         Metagenome pipeline
         =============================
         Inputs: ${params.inputDir}
         Outputs: ${params.outputDir}
         WorkDir: ${params.workDir}
         """
         .stripIndent()



include { Fastp } from './process/fastp'


workflow {
    
    reads_ch = Channel.fromFilePairs("${params.inputDir}/**/" + '*_{1,2}.*.gz', size: -1, maxDepth: 1)
    input = Channel.fromPath(params.inputDir, checkIfExists: true)

    reads_ch.view()
    
    Fastp(reads_ch )

}

workflow.onComplete {
    log.info ( workflow.success ? "Completed!" : "Error" )
}