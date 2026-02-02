process STAR_ALIGN 
{
    tag "$sample_id"

    cpus 4
    memory '6 GB'
    
    container 'quay.io/biocontainers/star:2.7.10b--h6b7c446_1'
    
    input:
    tuple val(sample_id), path(reads)
    
    output:
    tuple val(sample_id), path("*.bam"), emit: bam

    script:
    """
    STAR \
    genomeDir genome \
    --readFilesIn ${reads.join(' ')} \
    --runThreadN ${task.cpus} \
    --outSAMtype BAM sortedByCoordinate \
    """
}