#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
 * Load the RNA-seq workflow
 */
include { RNASEQ_WORKFLOW } from './workflows/rnaseq.nf'

/*
 * Read samplesheet and create a channel
 */
Channel
    .fromPath(params.samplesheet)
    .splitCsv(header: true)
    .map { row ->
        def r1 = file(row.fastq_1, checkIfExists: true)
        
        if (row.fastq_2) {
            def r2 = file(row.fastq_2, checkIfExists: true)
            return tuple(row.sample_id, [r1, r2]) 
        } else {
            return tuple(row.sample_id, r1)
        }
    }
    .set { samples_ch }

/*
 * Run workflow
 */
workflow {
    // We just pass the samples to the workflow. 
    // The workflow itself will handle building the index.
    RNASEQ_WORKFLOW(samples_ch)
}