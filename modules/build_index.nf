process BUILD_INDEX {
    tag "building_index"
    
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
    
    # 1. Unzip the files specifically for STAR (it requires plain text for indexing)
    gunzip -c ${fasta} > genome.fa
    gunzip -c ${gtf} > annotations.gtf
    
    # 2. Run STAR using the unzipped files
    STAR --runMode genomeGenerate \
         --genomeDir star_index \
         --genomeFastaFiles genome.fa \
         --sjdbGTFfile annotations.gtf \
         --runThreadN ${task.cpus} \
         --genomeSAindexNbases 11
    """
}