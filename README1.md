# 🧪 nf-rnaseq: RNA-Seq Analysis Pipeline

[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A523.04.0-23aa62.svg)](https://www.nextflow.io/)
[![Run with Docker](https://img.shields.io/badge/run%20with-docker-0db7ed?logo=docker)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📖 Introduction

**nf-rnaseq** is a portable bioinformatics analysis pipeline written in [Nextflow](https://www.nextflow.io) using **DSL2**. It handles the preprocessing, alignment, and quantification of RNA-sequencing data using containerized tools.

The pipeline is built for high reproducibility and scalability, designed to run seamlessly on local machines, HPC clusters, or cloud environments.

## 🧩 Workflow Architecture

The pipeline implements a modular design where each process is isolated, ensuring easy maintenance and a clean execution path.

![Pipeline DAG](./flowchart.png)

## ⚡ Pipeline Summary

1.  **Quality Control**: Raw read analysis using `FastQC`.
2.  **Preprocessing**: Adapter trimming and quality filtering using `fastp`.
3.  **Alignment**: Splice-aware mapping to the reference genome using `STAR`.
4.  **Quantification**: Gene-level feature counting using `featureCounts` (Subread).
5.  **Reporting**: Automated aggregation of all quality metrics into a single interactive `MultiQC` report.

## 🛡️ Validation & Reliability

* **Fail-Fast Check**: Integrated validation ensures the input samplesheet is not empty before initiating computational processes.
* **Modular DSL2**: Independent process definitions allow for flexible scaling and easier debugging.
* **Resource Optimized**: Default configurations for memory and CPU usage are provided to ensure stability in constrained environments.

## 🚀 Quick Start

1.  **Prerequisites**: Install Nextflow (`>=23.04.0`) and **Docker** (or Conda).

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

## 📦 Reproducibility

To ensure results can be replicated across different environments, this pipeline supports:
* **Docker**: Primary execution mode using Biocontainers for consistent tool versions.
* **Conda**: Fallback support for institutional clusters where container runtimes are restricted.

## 📂 Output Structure

Results are organized systematically in the `results/` directory:
* `quality_control/`: Final **MultiQC** dashboard and individual **FastQC** reports.
* `alignment/`: Coordinate-sorted **STAR** BAM files and **FeatureCounts** matrices.
* `preprocessing/`: Cleaned FastQ files and **fastp** execution logs.

## ✍️ Authors

* **Mohamedelmugtaba** - *Lead Developer* ([GitHub](https://github.com/mujtababarsi) | [LinkedIn](https://www.linkedin.com/in/mohamedelmugtaba-ibrahim-790151167/))
