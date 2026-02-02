process FEATURECOUNTS {
    tag "$sample_id" 
    cpus 2
    memory '2 GB'

    conda "${projectDir}/env/subread.yaml"

    input:
    tuple val(sample_id), path(bam)

    output:
    path "*.txt", emit: counts

    script:
    """
    featureCounts -a ${params.gtf} -o ${sample_id}_counts.txt $bam
    """
}