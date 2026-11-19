#!/usr/bin/env bash
set -euo pipefail

# Usage:
# bash 02_alignment_and_indexing.sh SRR30216716 4

SAMPLE="${1:?Provide an SRR accession, for example SRR30216716}"
THREADS="${2:-4}"
REFERENCE="/home/puja_chatterjee/ChIP_seq/reference/hg19"

CLEAN_FASTQ="${SAMPLE}_clean.fastq.gz"
SORTED_BAM="${SAMPLE}_sorted.bam"
ALIGNMENT_LOG="${SAMPLE}_alignment.log"

# Align single-end reads to hg19 and create a sorted BAM
bowtie2 -p "${THREADS}" \
  -x "${REFERENCE}" \
  -U "${CLEAN_FASTQ}" \
  2> "${ALIGNMENT_LOG}" |
samtools sort -@ 1 -m 256M -o "${SORTED_BAM}"

# Check BAM integrity
samtools quickcheck -v "${SORTED_BAM}"

# Create the BAM index required by IGV
samtools index -@ "${THREADS}" "${SORTED_BAM}"

# Display the final IGV-ready files
ls -lh "${SORTED_BAM}" "${SORTED_BAM}.bai"

echo "${SAMPLE}: alignment and BAM indexing completed."
