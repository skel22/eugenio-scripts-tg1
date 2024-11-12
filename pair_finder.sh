#!/bin/bash

words_file="../words_dict/words.txt"
word_pairs_file="../words_dict/words_pairs.txt"
output_dir="../words_dict"
output_file="$output_dir/words_pair_verification.txt"

mkdir -p "$output_dir"

if [[ ! -f "$words_file" ]]; then
    echo "Error: Words file not found at $words_file"
    exit 1
fi

if [[ ! -f "$word_pairs_file" ]]; then
    echo "Error: Word pairs file not found at $word_pairs_file"
    exit 1
fi

declare -A words
while read -r word _; do
    words["$word"]=1
done < "$words_file"

echo "Verification of word pairs against words.txt:" > "$output_file"
while read -r word1 word2 count; do
    if [[ -z "${words[$word1]}" || -z "${words[$word2]}" ]]; then
        echo "$word1 $word2 $count - Missing word(s)" >> "$output_file"
    else
        echo "$word1 $word2 $count - Both words found" >> "$output_file"
    fi
done < "$word_pairs_file"

echo "Word pair verification completed. Check $output_file for results."

