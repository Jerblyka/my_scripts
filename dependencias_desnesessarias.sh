#!/bin/bash

# Verifica pacotes não necessários e armazena em um array
mapfile -t unneeded_packages < <(zypper pa --unneeded | awk '$1 == "i" { print $5 "-" $7 }')

# Verifica se há pacotes para remover
if (( ${#unneeded_packages[@]} > 0 )); then
    echo "Removendo pacotes não necessários:"
    printf '%s\n' "${unneeded_packages[@]}"
    
    # Remove pacotes e exibe a saída detalhada
    zypper rm --clean-deps --details "${unneeded_packages[@]}"
else
    echo "Nenhum pacote não necessário encontrado."
fi
