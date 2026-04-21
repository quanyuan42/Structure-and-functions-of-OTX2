## Structure-and-functions-of-OTX2
Pipeline of analysis structure and functions of mouse OTX2.
# Preparation
The main software of the pipeline contains `IQtree`,`mafft`,`MACS` that can be downloaded on https://github.com/iqtree/iqtree3,https://github.com/GSLBiotech/mafft and https://github.com/macs3-project/MACS.
The reference genome contains [GRCm39](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001635.27/),the `.fastq` file [SRR10172882](https://trace.ncbi.nlm.nih.gov/Traces/index.html?run=SRR10172882) and [SRR10172850](https://trace.ncbi.nlm.nih.gov/Traces/index.html?run=SRR10172850) obtained via `SRA Toolkit`.
# Highly conserved domain of OTX2
Multiple sequence alignment software `MAFFT` L-INS-i algorithm are used for finding vertebrates orthologous OTX2 conserved amino acid sequences.
# Secondary and tertiary structure of conserved region
Secondery structure of conserved region is predicted by [PDB](https://www.rcsb.org/),the mouse OTX2 homeodomain presented on [iCn3D](https://www.ncbi.nlm.nih.gov/Structure/icn3d).
# OTX2 orthologs
`IQtree` was used to Construct a NJ-tree to visualize the distance of different vertebrates.
# Sequence alignment
`SRR10172882` and `SRR10172850` aligned to mouse reference genome [GRCm39](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001635.27/) by alignment software [bowtie2](https://github.com/BenLangmead/bowtie2).
```
conda install -y bowtie2
bowtie2-build GRCm39.fa ./index
bowtie2 -p 10 -x ./index -U SRR10172882.fq | samtools sort -O bam -@ 10 -o - > SRR10172882.bam
bowtie2 -p 10 -x ./index -U SRR10172850.fq | samtools sort -O bam -@ 10 -o - > SRR10172850.bam
```
# Binding motif of OTX2
Peak-calling agorithm of `MACS` used for calling peaks of `SRR10172882` vs `SRR10172850`,the motif discovered by webpage [MEME](https://meme-suite.org/meme/doc/meme.html?man_type=web).
# differential analysis
GEO data minning `GSE11582838`,differential expressing gene analysis by R package `edgR`,data visualize by R package `ggplot2`.
```
if(F){
  library(GEOquery)
  gset <- getGEO('GSE11582838', destdir=".",
                 AnnotGPL = F,
                 getGPL = F)
  save(gset,'GSE11582838.gset.Rdata')
}
load('GSE11582838_eSet.Rdata')
b = eSet[[1]] 
raw_exprSet=exprs(b) 
group_list=c(rep('control',3),rep('case',3))
save(raw_exprSet,group_list,
     file='GSE11582838_raw_exprSet.Rdata')
```
# GO enrichment analysis
The binding genes are analyzed on webpage [DAVID](https://davidbioinformatics.nih.gov/workspace.html).
