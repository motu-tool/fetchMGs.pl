
===============
 fetchMGs v 1.2 
===============



fetchMGs is copyright (c) 2019 Shinichi Sunagawa and Daniel R Mende
fetchMGs is released under the GNU General Public Licence v3.
Please see http://www.gnu.org/licenses/gpl.html and the seperately provided LICENSE file.



==============
 Introduction
==============
 
Phylogenetic markers are genes (and proteins) which can be used to reconstruct the
phylogenetic history of different organisms. One classical phylogenetic marker is the
16S ribosomal RNA gene, which is often-used but is also known to be a sub-optimal
phylogenetic marker for some organisms. Efforts to find a good set of protein coding
phylogenetic marker genes (Ciccarelli et al., Science, 2006; Sorek et al., Science, 2007)
lead to the identification of 40 universal single copy marker genes (MGs). These 40
marker genes occur in single copy in the vast majority of known organisms and they
were used to successfully reconstruct a three domain phylogenetic tree
(Ciccarelli et al., Science, 2006).



========================
 What the software does
========================
 
The program “fetchMGs” was written to extract the 40 MGs from genomes and
metagenomes in an easy and accurate manner. This is done by utilizing Hidden Markov
Models (HMMs) trained on protein alignments of known members of the 40 MGs as well
as calibrated cutoffs for each of the 40 MGs. Please note that these cutoffs are only
accurate when using complete protein sequences as input files. The output of the program
are the protein sequences of the identified proteins, as well as their nucleotide sequences,
if the nucleotide sequences of all complete genes are given as an additional input.



=======
 Input
=======

A fasta file with protein coding sequences, and optionally the gene sequences of the proteins.
If the DNA sequences are available, the corresponding genes of the proteins, are also extracted.



========
 Output
========

The output of this software is saved within the specified output folder and consists of:
- 40 x COGxxxx.faa files (sequences of extracted proteins)
- 40 x COGxxxx.fna files (sequences of extracted genes)
-      marker_genes_scores.table (protein <TAB> score <TAB> marker gene ID <TAB> genome identifier)
-      temp (identifiers of proteins identified homologous to any marker gene)
-      hmmResults (specific output files from HMMer3)



=========
 Example 
=========

./fetchMGs.pl -m extraction -x bin example_dataset/example_data.faa



====================
 Full program help
====================

Help & Manual
       fetchMGs.pl -h|help

Usage
       fetchMGs.pl -m|mode <extraction|calibration> [OPTIONS]

Extraction mode
       ./fetchMGs.pl [options] -m extraction <protein sequences>
           <protein sequences>           Multi-FASTA file with protein sequences from which universal single-copy marker genes should be extracted
           -c|og_used                    Orthologous group id to be extracted; example: \'COG0012\'; default = \'all\'
           -o|outdir                     Output directory; default = \'output\'
           -b|bitscore                   Path to bitscore cutoff file;
                                           Default = \'\$pathInWhichThisScriptResides/lib/MG_BitScoreCutoffs.[allhits|verybesthit].txt\' (depending on -v option)
           -l|library                    Path to directory that contains hmm models;
                                           default = \'\$pathInWhichThisScriptResides/lib\'
           -p|protein_only               Set if nucleotide sequences file for <protein sequences> is not available
           -d|dnaFastaFile               Multi-FASTA file with nucleotide sequences file for <protein sequences>;
                                                   not neccesary if protein and nucleotide fasta file have the same name except .faa and .fna suffixes
           -v|verybesthit_only               Only extract the best hit of each OG from each genome.
                                                  Recommended to use, if extracting sequences from multiple reference genomes in the same file.
                                                  Do not use it for metagenomes.
                                                  If this option is set fasta identifiers should be in the form: taxID.geneID and, if needed, have 'project_id=XXX' in the header.
                                                  Alternatively, set -i to ignore the headers. Then, the best hit of each OG in the whole input file will be selected, regardless of the headers used.
           -i|ignore_headers                 If this option is set in addition to -v, the best hit of each COG will be selected.
                                                  Recommended to use, if extracting sequences from a single genome in the same file.
           -t|threads                    Number of processors/threads to be used
           -x|executables                Path to executables used by this script (hmmsearch; seqtk).
                                                   default = \'\$pathInWhichThisScriptResides/bin\'
                                                   If set to \'\' will search for executables in \$PATH

Calibration mode
       ./fetchMGs.pl -m calibration <reference protein sequences> <true positives map>
           <reference protein sequences>     Multi-FASTA file with protein sequences that include marker genes (true positives)
           <true positives map>              Tab-delimited file with true positive protein identifiers and COG IDs



=======================
 Software dependencies
=======================

The fetchMGs script requires the seqtk and HMMer3 executables.
These software are (c) respecitve authors, and have been installed
in the bin folder, within the fetchMG folder.

HMMer3: http://hmmer.janelia.org/
seqtk: https://github.com/lh3/seqtk
