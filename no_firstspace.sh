#!/bin/bash

input_file="../corpus/deu_mixed-typical_2011_300K-sentences.txt"
output_dir="../corpus_txt"
output_file="$output_dir/deu_mixed_processed.txt"

mkdir -p "$output_dir"

gawk '{$1=""; print substr($0, 2) }' "$input_file" > "$output_file"
