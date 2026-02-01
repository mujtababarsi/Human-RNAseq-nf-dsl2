include { FastQC } from '../modules/fastqc.nf'
include { FASTP  } from '../modules/fastp.nf'
include { HISAT2_ALIGN } from '../modules/hisat2.nf'
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
     * Align reads using HISAT2
     */
    hisat2_out = HISAT2_ALIGN(fastp_out.trimmed)

    emit:
    /*
     * Emit FastQC outputs separately
     */
    fastqc_html = fastqc_out.html
    fastqc_zip  = fastqc_out.zip

    /*
     * Emit Fastp outputs
     */
    trimmed_reads = fastp_out.trimmed
    fastp_report  = fastp_out.report
    fastp_json    = fastp_out.json
}
