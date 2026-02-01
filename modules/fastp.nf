process FASTP {

    tag "$sample_id"
    publishDir "${params.outdir}/preprocessing/fastp", mode: 'copy'

    cpus 2
    memory '2 GB'

    conda "${projectDir}/envs/fastp.yml"

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("*.fq.gz"), emit: trimmed
    path "*.html", emit: report
    path "*.json", emit: json

    script:
    """
    fastp \
        -i ${reads} \
        -o ${sample_id}.trimmed.fq.gz \
        --detect_adapter_for_pe false \
        --thread ${task.cpus} \
        --html ${sample_id}_fastp.html \
        --json ${sample_id}_fastp.json
    """
}
