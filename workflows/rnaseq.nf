include { FastQC } from '../modules/fastqc.nf'
include { FASTP  } from '../modules/fastp.nf'
include { STAR_ALIGN }    from '../modules/star.nf'
include { FEATURECOUNTS } from '../modules/featurecounts.nf'
include { MULTIQC } from '../modules/multiqc.nf'

workflow RNASEQ_WORKFLOW {

    take:
    samples_ch

    main:
    /*
     * Run FastQC
     * This returns multiple named outputs
     */
    fastqc_out = FastQC(samples_ch)

    /*
     * Run Fastp trimming
     */
    fastp_out = FASTP(samples_ch)
    /*
     * Align reads using STAR
     */
    star_out = STAR_ALIGN(fastp_out.trimmed)
    /*
     * Quantify features using FeatureCounts
     */
    counts_out = FEATURECOUNTS(star_out.bam)
    /*
     * Aggregate reports using MultiQC
     */
    qc_files = Channel.merge(
        fastqc_out,
        fastp_out,
        star_out,
        featurecounts_out
    )
    MULTIQC(qc_files)
     
    emit:
    
    fastqc_html = fastqc_out.html
    fast_zip = fastqc_out.zip

    trimmed_reads = fastp_out.trimmed
    fastp_report = fastp_out.report
   
    
    bam_files = star_out.bam
    gene_counts = counts_out.counts
    }
