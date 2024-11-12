#!/bin/bash

input_file="../corpus/deu_mixed-typical_2011_300K-sentences.txt"
output_dir="../sentences_dict"
output_file="$output_dir/sentences.txt"

mkdir -p "$output_dir"

awk '
{
    # Substituir espaços nas frases pelo caractere "|"
    gsub(" ", "|", $0)
    # Contar a ocorrência de cada frase
    sentence_count[$0]++
}
END {
    # Imprimir cada frase e a respetiva contagem
    for (sentence in sentence_count) {
        print sentence_count[sentence] " " sentence
    }
}' "$input_file" | sort > "$output_file"

echo "Ficheiro sentences.txt criado com sucesso em $output_dir!"

