process STAR_ALIGN {
    tag "$sample_id"

    cpus 4
    memory '6 GB'
    
    conda "${projectDir}/envs/star.yml"
    
    input:
    tuple val(sample_id), path(reads*)
    
    output:
    tuple val(sample_id), path("*.bam"), emit:bam

    script:
    """
    STAR \
    genomeDir genome \
    --readFilesIn ${reads.join(' ')} \
    --runThreadN ${task.cpus} \
    --outSAMtype BAM sortedByCoordinate \
    """
}