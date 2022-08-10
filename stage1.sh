##using wget command to download the DNA.fa link
wget https://raw.githubusercontent.com/HackBio-Internship/wale-home-tasks/main/DNA.fa

##counting the number of sequence in the downloaded DNA.fa file
grep -v ">" DNA.fa | wc

##counting the total sequence of A|T|C|G counts in the DNA.fa file
grep -v ">" DNA.fa | grep -E -o "A|T|C|G" | wc -l

##using wget command to install the miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh

##using bash command to run the conda
bash Miniconda3-py39_4.12.0-Linux-x86_64.sh 

##using the conda to install softwares
    
conda install -c bioconda fastqc
conda install -c bioconda fastp
conda install -c bioconda bwa
conda install -c bioconda multiqc
conda install -c bioconda samtools

##downloading my datasets with the wget command

wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Alsen_R1.fastq.gz?raw=true
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Alsen_R2.fastq.gz?raw=true
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Baxter_R1.fastq.gz?raw=true
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Baxter_R2.fastq.gz?raw=true
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Chara_R1.fastq.gz?raw=true
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Chara_R2.fastq.gz?raw=true
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Drysdale_R1.fastq.gz?raw=true
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Drysdale_R2.fastq.gz?raw=true 

##moved(renaming) all my downloaded datasets to fastq.gz files(compressed)
   
mv Alsen_R1.fastq.gz?raw=true Alsen_R1.fastq.gz
mv Alsen_R2.fastq.gz?raw=true Alsen_R2.fastq.gz
mv Baxter_R1.fastq.gz?raw=true Baxter_R1.fastq.gz
mv Baxter_R2.fastq.gz?raw=true Baxter_R2.fastq.gz   
mv Chara_R1.fastq.gz?raw=true Chara_R1.fastq.gz
mv Chara_R2.fastq.gz?raw=true Chara_R2.fastq.gz  
mv Drysdale_R1.fastq.gz?raw=true Drysdale_R1.fastq.gz
mv Drysdale_R2.fastq.gz?raw=true Drysdale_R2.fastq.gz

##created directory raw_reads and moved the datasets into it
mkdir raw_reads
mv *fastq.gz raw_reads

##using fastp on my raw_reads datasets and output into output directory
mkdir output
fastp -i Alsen_R1.fastq.gz -I Alsen_R2.fastq.gz -o ../output/Alsen_R1_trim.fastq.gz -O ../output/Alsen_R2_trim.fastq.gz --html ../output/vtR.html
fastp -i Chara_R1.fastq.gz -I Chara_R2.fastq.gz -o ../output/Chara_trim.fastq.gz -O ../output/Chara_trim2.fastq.gz --html ../output/cht.html
fastp -i Drysdale_R1.fastq.gz -I Drysdale_R2.fastq.gz -o ../output/Drysdale_trim.fastq.gz -O ../output/Drysdale_trim2.fastq.gz --html ../output/Drys.html  

##Using fastqc on my trimmed files

fastqc Alsen_R1_trim.fastq.gz -o ../QC_report/
fastqc Alsen_R2_trim.fastq.gz -o ../QC_report/
fastqc Baxter_trim.fastq.gz -o ../QC_report/
fastqc Baxter_trim2.fastq.gz -o ../QC_report/
fastqc Chara_trim.fastq.gz -o ../QC_report/
fastqc Chara_trim2.fastq.gz -o ../QC_report/
fastqc Drysdale_trim.fastq.gz -o ../QC_report/
fastqc Drysdale_trim2.fastq.gz -o ../QC_report/

##using BWA
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/repaired/ACBarrie_R1_rep.fastq.gz?raw=true
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/repaired/ACBarrie_R2_rep.fastq.gz?raw=true

mv ACBarrie_R1_rep.fastq.gz?raw=true ACBarrie_R1_rep.fastq.gz
mv ACBarrie_R2_rep.fastq.gz?raw=true ACBarrie_R2_rep.fastq.gz


##make directory for reference
mkdir reference && cd reference

##wget the reference
wget https://github.com/josoga2/yt-dataset/raw/main/dataset/references/reference.fasta

##using bwa to reference
bwa index reference.fasta

##align the genome
mkdir alignment
bwa mem reference/reference.fasta ACBarrie_R1_rep.fastq.gz ACBarrie_R2_rep.fastq.gz >alignment/ACBarrie.sam

##using multiqc
pip install multiqc
multiqc QC_reports/

##using samtools
conda install -c bioconda samtools

##in the alignment directory
samtools view -S -b ACBarrie.sam > sample_ACBarrie.bam

##to view the top 5
samtools view sample_ACBarrie.bam | head -n 5

## to sort te files
samtools sort sample_ACBarrie.bam -o sample_ACBarrie_sorted.bam

##to view the sorted file
samtools view sample_ACBarrie_sorted.bam | head -n 5


                                                                                                                                                                                                                                                             
