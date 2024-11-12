#!/bin/bash

input_file="../corpus/deu_mixed-typical_2011_300K-sentences.txt"
output_dir="../words_dict"
output_file="$output_dir/words_pairs.txt"

mkdir -p "$output_dir"

if [[ ! -f "$input_file" ]]; then
    echo "Error: Input file not found at $input_file"
    exit 1
fi

awk '{
    # Loop through each word in the line to create pairs
    for (i = 1; i < NF; i++) {
        pair = tolower($i) " " tolower($(i + 1))
        pairs[pair]++
    }
}
END {
    # Print each pair and its count
    for (pair in pairs) {
        print pair, pairs[pair]
    }
}' "$input_file" | sort > "$output_file"

echo "Word pairs frequency file created at $output_file"

