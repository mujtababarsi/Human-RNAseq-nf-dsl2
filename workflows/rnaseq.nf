include { FastQC } from '../modules/fastqc.nf'
include { FASTP  } from '../modules/fastp.nf'
include { STAR_ALIGN }    from '../modules/star.nf'
include { FEATURECOUNTS } from '../modules/featurecounts.nf'
include { MULTIQC } from '../modules/multiqc.nf'
include { BUILD_INDEX } from '../modules/build_index.nf'
workflow RNASEQ_WORKFLOW {

    take:
    samples_ch

    main:

    //build the index
    index_ch = BUILD_INDEX(file(params.fasta), file(params.gtf))
    /*
     * Run FastQC
     */
    fastqc_out = FastQC(samples_ch)

    /*
     * Run Fastp trimming
     */
    fastp_out = FASTP(samples_ch)

    /*
     * Align reads using STAR
     * FIX: Added params.genome as the 2nd argument
     */
    star_out = STAR_ALIGN(fastp_out.trimmed)

    /*
     * Quantify features using FeatureCounts
     * NOTE: If this module also expects a GTF, you may need to add params.gtf here later.
     */
    counts_out = FEATURECOUNTS(star_out.bam)

    /*
     * Aggregate reports using MultiQC
     * FIX: specific channels (.json, .log) selected for cleaner mixing
     */
    qc_files = Channel.empty()
        .mix(fastqc_out)
        .mix(fastp_out.json)   // Capture the JSON report
        .mix(fastp_out.report) // Capture the HTML report
        .mix(star_out.log)     // Capture the STAR Log.final.out
        .mix(counts_out.counts)// Capture FeatureCounts output
        .collect()
        
    MULTIQC(qc_files)
     
    emit:
    bam = star_out.bam
    counts = counts_out.counts
}   