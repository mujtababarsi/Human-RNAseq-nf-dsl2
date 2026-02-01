nextflow.enable.dsl=2
include {FASTQC} from '../modules/fastqc'
// workflow to perform RNA-seq quality control
workflow RNASEQ_WORKFLOW { 

    //channels
    samples_ch = Channel.fromPath(params.input)
                 .splitCsv(header:true)
                 .map { row ->
                        tuple(row.sample, file(row.fastq))
                    }
    FASTQC(samples_ch)
}

