#!/bin/bash

# Este script desabilita o swap permanentemente de forma segura.

# Função para exibir mensagens
log() {
    echo "[INFO] $1"
}

# Verifica se está sendo executado como root
if [ "$EUID" -ne 0 ]; then
    echo "[ERRO] Este script precisa ser executado como root. Use 'sudo'."
    exit 1
fi

log "Criando backup do arquivo /etc/fstab..."
cp /etc/fstab /etc/fstab.bak
if [ $? -ne 0 ]; then
    echo "[ERRO] Falha ao criar o backup de /etc/fstab. Abortando."
    exit 1
fi
log "Backup criado em /etc/fstab.bak."

log "Comentando entradas de swap no arquivo /etc/fstab..."
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
if [ $? -ne 0 ]; then
    echo "[ERRO] Falha ao comentar entradas de swap em /etc/fstab. Verifique manualmente."
    exit 1
fi
log "Entradas de swap comentadas com sucesso."

log "Desativando o swap atual..."
swapoff -a
if [ $? -ne 0 ]; then
    echo "[ERRO] Falha ao desativar o swap. Verifique o estado do sistema."
    exit 1
fi
log "Swap desativado com sucesso."

SWAPFILE="/swapfile"
if [ -f "$SWAPFILE" ]; then
    log "Removendo o arquivo de swap: $SWAPFILE..."
    rm -f "$SWAPFILE"
    if [ $? -ne 0 ]; then
        echo "[ERRO] Falha ao remover o arquivo de swap. Verifique manualmente."
        exit 1
    fi
    log "Arquivo de swap removido com sucesso."
else
    log "Nenhum arquivo de swap encontrado em $SWAPFILE."
fi

log "Verificação final: Certifique-se de que o swap foi desativado."
swapon --show
if [ $? -ne 0 ]; then
    log "Não há swaps ativos. Processo concluído com sucesso."
else
    log "Ainda há swaps ativos. Verifique manualmente."
fi
