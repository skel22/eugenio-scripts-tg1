#!/bin/bash

input_file="../corpus/deu_mixed-typical_2011_300K-sentences.txt"
output_dir="sentences_dict"
output_file="$output_dir/sentences_pairs.txt"
mkdir -p "$output_dir"

# Verifica se o arquivo de entrada existe
if [[ ! -f "$input_file" ]]; then
  echo "Erro: Arquivo de entrada não encontrado em $input_file"
  exit 1
fi

# Gera pares e conta as ocorrências de forma eficiente
awk '
BEGIN {
  # Inicializa o array de contagem de pares
  OFS=" ";
}

{
  # Substitui espaços por | em cada linha (frase)
  gsub(" ", "|", $0);
  
  # Processa as frases como par
  for (i = 1; i <= NR - 1; i++) {
    pair = sentences[i] OFS $0;
    pairs_count[pair]++;
  }
  
  # Armazena a frase atual para comparações futuras
  sentences[NR] = $0;
}

END {
  # Ordena e escreve os pares no arquivo de saída
  PROCINFO["sorted_in"] = "@ind_str_asc";
  for (pair in pairs_count) {
    print pair, pairs_count[pair] > "'"$output_file"'"
  }
}
' "$input_file"

echo "Arquivo de pares de frases criado em: $output_file"

