# Print help text
echo -e "\nfetchMGs retrieves sequences homologous to 40 universal marker genes"
echo -e "from a fasta formatted file with protein coding sequences.\n"

# Extract example data
echo -e "Extracting sequence files.\n"
gunzip example_datasets/*.f*a.gz

# Run fethMG on metagenome examples
echo -e "Running fetchMGs on metagenomic genes"
./fetchMGs.pl -m extraction -o example_output_metagenome example_datasets/example_data.faa -t 8

# Run fethMGs on genome examples
echo -e "Running fetchMGs on genomes"
./fetchMGs.pl -m extraction -v -o example_output_genome example_datasets/example_data_genomes.faa -t 8

# Print help text
echo -e "============================================================================="
echo -e "\nfetchMGs has finished. The sequences of the 40 marker genes"
echo -e "are now saved in the ./example_output_metagenome and ./example_output_genome"
echo -e "============================================================================="
