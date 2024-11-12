#!/bin/bash

input_file="../corpus/deu_mixed-typical_2011_300K-sentences.txt"
output_dir="../words_dict"
output_file="$output_dir/words.txt"

mkdir -p "$output_dir"

if [[ ! -f "$input_file" ]]; then
    echo "Error: Input file not found at $input_file"
    exit 1
fi

awk '{ for(i=1; i<=NF; i++) words[tolower($i)]++ } 
     END { for(word in words) printf "%s %d\n", word, words[word] }' "$input_file" | 
sort > "$output_file"

echo "Word frequency file created at $output_file"

