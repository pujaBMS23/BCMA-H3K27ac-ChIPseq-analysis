# BCMA H3K27ac ChIP-seq Analysis

Bioinformatics analysis of H3K27ac ChIP-seq data from MM.1S multiple myeloma cells following KB528 treatment.

## Study objective

To identify treatment-associated changes in H3K27ac enrichment near **BCMA (TNFRSF17)** and investigate whether these changes correlate with gene expression.

## Dataset

- **GEO accession:** GSE274593
- **Cell line:** MM.1S
- **Conditions:** DMSO, KB528 1 h, 3 h, 6 h and 24 h
- **Replicates:** Two biological replicates per condition
- **Reference genome:** hg19
- **Samples:** 10 single-end ChIP-seq libraries

Sample details are provided in `metadata/sample_information.csv`.

## Analysis workflow

1. FASTQ integrity check
2. Raw-read quality control using FastQC
3. Adapter and quality trimming using fastp
4. Post-trimming quality control
5. Alignment to hg19 using Bowtie2
6. BAM sorting and indexing using SAMtools
7. Visual inspection in IGV
8. Peak comparison between DMSO and KB528-treated samples
9. Integration with RNA-seq expression results

## Repository structure

```text
BCMA-H3K27ac-ChIPseq-analysis/
├── metadata/
│   └── sample_information.csv
├── scripts/
│   ├── 01_qc_and_trimming.sh
│   └── 02_alignment_and_indexing.sh
├── .gitignore
└── README.md
```

## Scripts

### Quality control and trimming

```bash
bash scripts/01_qc_and_trimming.sh SRR30216721 4
```

### Alignment and BAM indexing

```bash
bash scripts/02_alignment_and_indexing.sh SRR30216721 4
```

Replace `SRR30216721` with the required sample accession.

## Software

- FastQC
- fastp
- Bowtie2
- SAMtools
- IGV

## Data availability

Raw sequencing data are available from the NCBI Sequence Read Archive under GEO accession **GSE274593**. Large FASTQ, BAM and reference-index files are excluded from this repository.
