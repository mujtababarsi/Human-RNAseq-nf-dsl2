process STAR_ALIGN {

    tag "$sample_id"

    container 'quay.io/biocontainers/star:2.7.10b--h6b7c446_1'
   
    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("${sample_id}_Aligned.sortedByCoord.out.bam"), emit: bam
    path "${sample_id}_Log.final.out", emit: log

    script:
    """
    STAR \
      --genomeDir ${params.genome} \
      --readFilesIn ${reads} \
      --runThreadN ${task.cpus} \
      --readFilesCommand zcat \
      --outFileNamePrefix ${sample_id}_ \
      --outSAMtype BAM SortedByCoordinate \
      --outSAMunmapped Within \
      --outSAMattributes Standard
    """
}
