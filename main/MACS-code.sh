#MACS3 peakcalling
conda install -c bioconda macs3;
macs3 callpeak -t SRR10172882.bam -c SRR10172850.bam -f BAM -g hs -n test -B -q 0.01;