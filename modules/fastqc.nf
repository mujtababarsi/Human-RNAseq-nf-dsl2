process FastQC {

    tag "$sample_id"
    publishDir "${params.outdir}/quality_control/fastqc", mode: 'copy'

    cpus 1
    memory '1 GB'

    conda "${projectDir}/envs/fastqc.yml"

    input:
    tuple val(sample_id), path(fastq)

    output:
    path "*.zip",  emit: zip
    path "*.html", emit: html

    script:
    """
    fastqc $fastq --outdir .
    """
}
