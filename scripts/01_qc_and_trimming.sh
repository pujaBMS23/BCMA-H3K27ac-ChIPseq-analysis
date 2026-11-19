#!/usr/bin/env bash
set -euo pipefail

# Usage:
# bash 01_qc_and_trimming.sh SRR30216716 4

SAMPLE="${1:?Provide an SRR accession, for example SRR30216716}"
THREADS="${2:-4}"
ADAPTER="GATCGGAAGAGCGGTTCAGCAGGAATGCCGAGAC"

RAW_FASTQ="${SAMPLE}.fastq.gz"
CLEAN_FASTQ="${SAMPLE}_clean.fastq.gz"

mkdir -p "results/fastqc/${SAMPLE}/before"
mkdir -p "results/fastqc/${SAMPLE}/after"
mkdir -p "results/fastp"

# Confirm that the downloaded FASTQ is complete
gzip -t "${RAW_FASTQ}"

# Quality control before cleaning
fastqc "${RAW_FASTQ}" \
  --outdir "results/fastqc/${SAMPLE}/before" \
  --threads "${THREADS}"

# Adapter and quality trimming
fastp \
  -i "${RAW_FASTQ}" \
  -o "${CLEAN_FASTQ}" \
  --adapter_sequence "${ADAPTER}" \
  --cut_right \
  --cut_right_window_size 4 \
  --cut_right_mean_quality 20 \
  --length_required 30 \
  --thread "${THREADS}" \
  --html "results/fastp/${SAMPLE}_fastp_report.html" \
  --json "results/fastp/${SAMPLE}_fastp_report.json"

# Quality control after cleaning
fastqc "${CLEAN_FASTQ}" \
  --outdir "results/fastqc/${SAMPLE}/after" \
  --threads "${THREADS}"

echo "${SAMPLE}: QC and trimming completed successfully."
