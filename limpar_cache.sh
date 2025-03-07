#!/bin/bash 
sudo clear ;
free -h ;
sudo sync ;

# Estas opções abaixo podem ser usadas em qualquer sistema linux, somente descomente a linha a ser usada.
# Limpa a memória cache da RAM sem afetar os dados ativos
#echo 1 | sudo tee /proc/sys/vm/drop_caches > /dev/null
# Limpa dentries e inodes do cache da RAM sem prejudicar processos ativos
#echo 2 | sudo tee /proc/sys/vm/drop_caches > /dev/null
# Limpa dentries, inodes e páginas de memória de arquivos inativos
#echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null

# Estas opções abaixo ficam mais estáveis quando se usa o systemd, ou em alguma distribuição linux que use também o sysctl.
# Limpa a memória cache da RAM sem afetar os dados ativos
#sudo sysctl -w vm.drop_caches=1 ;
# Limpa dentries e inodes do cache da RAM sem prejudicar processos ativos
#sudo sysctl -w vm.drop_caches=2 ;
# Limpa dentries, inodes e páginas de memória de arquivos inativos
sudo sysctl -w vm.drop_caches=3 ;

sudo sync ;

free -h ;
