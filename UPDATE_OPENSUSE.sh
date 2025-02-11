#!/bin/bash 
sudo clear ;

#Atualiza o repositório
sudo zypper ref ;
#Mostra se tem atualizações
sudo zypper lu ;
#Atualiza toda a distro
sudo zypper dup ;