/*
 * RNA-SEQ WORKFLOW 
 * -----------------------------------------------------------
 * This is the main logic for the pipeline. It handles everything 
 * from initial QC to the final MultiQC aggregation.
 */

include { BUILD_INDEX }   from '../modules/build_index.nf'
include { FastQC }        from '../modules/fastqc.nf'
include { FASTP  }        from '../modules/fastp.nf'
include { STAR_ALIGN }    from '../modules/star.nf'
include { FEATURECOUNTS } from '../modules/featurecounts.nf'
include { MULTIQC }       from '../modules/multiqc.nf'

workflow RNASEQ_WORKFLOW {
    take: samples_ch

    main:
    // First, make sure the samplesheet isn't empty. 
    // No point running the whole thing if there's no data.
    samples_ch
        .ifEmpty { error "The input samplesheet is empty. Please check: assets/samplesheet.csv" }

    // Kick off the genome indexing using the fasta and gtf from config
    index_ch = BUILD_INDEX(
        file(params.fasta, checkIfExists: true), 
        file(params.gtf, checkIfExists: true)
    ).index

    // Run basic quality control and preprocessing on raw reads
    // I'm specifically pulling out the .html for MultiQC later
    fastqc_out = FastQC(samples_ch).html
    fastp_out  = FASTP(samples_ch)

    // Alignment step: taking the trimmed reads and mapping them to the index
    star_out = STAR_ALIGN(fastp_out.trimmed, index_ch)

    // Generate gene counts from the BAM files
    counts_out = FEATURECOUNTS(star_out.bam)

    // Gathering all the different logs and reports for the final MultiQC.
    // I'm mixing these into one channel and collecting them to ensure 
    // MultiQC only starts once everything else is finished.
    qc_files = fastqc_out
        .mix(fastp_out.json)
        .mix(fastp_out.report)
        .mix(star_out.log)
        .mix(counts_out.counts)
        .collect()
        
    MULTIQC(qc_files)
     
    emit:
    bam    = star_out.bam
    counts = counts_out.counts
}