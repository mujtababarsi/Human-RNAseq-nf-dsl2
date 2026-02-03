# 🧪 nf-rnaseq: RNA-Seq Analysis Pipeline

[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A523.04.0-23aa62.svg)](https://www.nextflow.io/)
[![Run with Docker](https://img.shields.io/badge/run%20with-docker-0db7ed?logo=docker)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📖 Introduction

**nf-rnaseq** is a portable bioinformatics analysis pipeline written in [Nextflow](https://www.nextflow.io) using **DSL2**. It handles the preprocessing, alignment, and quantification of RNA-sequencing data using containerised tools (Docker).

The pipeline is built for reproducibility and scalability, designed to run on local machines, HPC clusters, or cloud environments.

## ⚡ Pipeline Summary

1.  **Quality Control**: Raw read analysis using `FastQC`.
2.  **Preprocessing**: Adapter trimming and quality filtering using `fastp`.
3.  **Alignment**: Mapping reads to the reference genome using `STAR`.
4.  **Quantification**: Counting reads per gene using `featureCounts` (Subread).
5.  **Reporting**: Aggregating all quality metrics into a single interactive report using `MultiQC`.

## 🚀 Quick Start

1.  **Install Nextflow** (`>=23.04.0`) and **Docker**.

2.  **Clone the repository**:
    ```bash
    git clone [https://github.com/mujtababarsi/nf-rnaseq.git](https://github.com/mujtababarsi/nf-rnaseq.git)
    cd nf-rnaseq
    ```

3.  **Run the pipeline**:
    ```bash
    nextflow run main.nf \
      --fasta /path/to/genome.fa \
      --gtf /path/to/genes.gtf \
      --outdir ./results \
      -profile docker \
      -resume
    ```

## 📂 Output Structure

After the run completes, results are organised in the `results/` directory:

* `quality_control/`: **MultiQC** and **FastQC** HTML reports.
* `alignment/`: **STAR** BAM files and **FeatureCounts** matrices.
* `preprocessing/`: Trimmed FastQ files and **fastp** JSON reports.

## 🛠️ Tools Used

* [Nextflow](https://www.nextflow.io/)
* [STAR](https://github.com/alexdobin/STAR)
* [Subread (featureCounts)](http://subread.sourceforge.net/)
* [MultiQC](https://multiqc.info/)
* [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
* [fastp](https://github.com/OpenGene/fastp)

## ✍️ Authors

* **Mohamedelmugtaba** - *Lead Developer*
