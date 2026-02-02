process BUILD_INDEX {
    tag "building_index"
    
    // Low memory for laptop (Chr22 only)
    memory '4 GB' 
    cpus 2

    container 'quay.io/biocontainers/star:2.7.10b--h6b7c446_1'

    input:
    path fasta
    path gtf

    output:
    path "star_index", emit: index

    script:
    """
    mkdir star_index
    
    STAR --runMode genomeGenerate \
         --genomeDir star_index \
         --genomeFastaFiles ${fasta} \
         --sjdbGTFfile ${gtf} \
         --runThreadN ${task.cpus} \
         --genomeSAindexNbases 11
    """
}