process FASTP {

    tag "$sample_id"
    publishDir "${params.outdir}/preprocessing/fastp", mode: 'copy'

    cpus 2
    memory '2 GB'

    container 'quay.io/biocontainers/fastp:0.23.4--hadf994f_1'
    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("*.fq.gz"), emit: trimmed
    path "*.html", emit: report
   

    script:
    reads.size() == 2 ? 
    
    """
    fastp -i ${reads[0]} -I ${reads[1]} 
          -o ${sample_id}_R1.fq.gz \
          -O ${sample_id}_R2.fq.gz \
          --thread ${task.cpus} \
          --html ${sample_id}_fastp.html \
    """
    :
    """
    fastp -i ${reads[0]} \  
          -o ${sample_id}.fq.gz \
          --thread ${task.cpus} \
          --html ${sample_id}.html
    """
}
