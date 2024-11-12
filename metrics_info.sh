#!/bin/bash

input_file="../corpus/deu_mixed-typical_2011_300K-sentences.txt"
output_dir="../corpus_info"
output_file="$output_dir/corpus_info.txt"

if [[ ! -f "$input_file" ]]; then
  echo "Error: Input file not found at $input_file"
  exit 1
fi

mkdir -p "$output_dir"

num_chars=$(wc -m < "$input_file")
non_empty_lines=$(grep -cv '^$' "$input_file")
total_words=$(wc -w < "$input_file")

unique_words=$(awk '{ for(i=1; i<=NF; i++) words[$i]++ } END { print length(words) }' "$input_file")
words_ratio=$(awk "BEGIN { printf \"%.4f\", $unique_words / $total_words }")

total_sentences=$(wc -l < "$input_file")

unique_sentences=$(sort "$input_file" | uniq | wc -l)
sentences_ratio=$(awk "BEGIN { printf \"%.4f\", $unique_sentences / $total_sentences }")

echo "Número total de caracteres: $num_chars" > "$output_file"
echo "Quantidade de linhas não vazias: $non_empty_lines" >> "$output_file"
echo "Número total de palavras: $total_words" >> "$output_file"
echo "Número total de palavras diferentes: $unique_words" >> "$output_file"
echo "Quociente entre total de palavras diferentes e total de palavras: $words_ratio" >> "$output_file"
echo "Número total de frases: $total_sentences" >> "$output_file"
echo "Número total de frases diferentes: $unique_sentences" >> "$output_file"
echo "Quociente entre total de frases diferentes e total de frases: $sentences_ratio" >> "$output_file"

