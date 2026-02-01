nextflow.enable.dsl=2

// FastQC process to perform quality control on sequencing data
process FastQC {
    tag "${sample_id}"
    //resource usage
    cpus 1
    memory '1 GB'

    //docker image
    container 'quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0'

    input:
    tuple val(sample_id), path(fastq)

    output:
    path "*.zip", emit: zip
    path "*.html", emit: html

    script:
    """
    fastqc $fastq --outdir . 
    """
}