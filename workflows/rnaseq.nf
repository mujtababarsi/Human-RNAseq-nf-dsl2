/*
 * High-level RNA-seq workflow
 * Runs FastQC on single-end RNA-seq data
 */

nextflow.enable.dsl=2

include { FastQC } from '../modules/fastqc'

workflow RNASEQ_WORKFLOW {

    /*
     * Read samplesheet CSV
     * Produces tuples: (sample_id, fastq)
     */
    samples_ch = Channel
        .fromPath(params.input)
        .splitCsv(header: true)
        .map { row ->
            tuple(row.sample, file(row.fastq))
        }

    /*
     * Run FastQC
     */
    FASTQC(samples_ch)
}