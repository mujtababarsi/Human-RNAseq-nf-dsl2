process MULTIQC {
    // Defines where to save the output and 'copy' ensures it remains even if work/ is deleted
    publishDir "${params.outdir}/multiqc", mode: 'copy'

    cpus 1
    memory '1 GB'

    container 'quay.io/biocontainers/multiqc:1.19--pyhdfd78af_0'
    
    input:
    path reports

    output:
    path "multiqc_report.html" 

    script:
    """
    multiqc .
    """
}