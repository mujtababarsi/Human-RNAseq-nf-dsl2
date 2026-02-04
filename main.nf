#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
 * 1. Load Pipeline Modules
 */
include { RNASEQ_WORKFLOW } from './workflows/rnaseq.nf'

/*
 * 2. Input Parameter Handling
 * Parses the provided samplesheet to create input channels for
 * Single-end or Paired-end reads.
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
 * 3. Main Workflow Execution
 * Runs the alignment, quantification, and QC steps.
 */
workflow {
    RNASEQ_WORKFLOW(samples_ch)
}