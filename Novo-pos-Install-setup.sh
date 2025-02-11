#!/bin/bash

# Atualizando os repositórios e o sistema
sudo apt update -y && sudo apt upgrade -y

# Instalando os pacotes
sudo apt install -y ksnip vlc psensor gnome-system-monitor default-jre bluedevil streamlink mpv ffmpeg chrony htop

# Configurando o sistema para PT-BR
#sudo apt install -y locales
#sudo locale-gen pt_BR.UTF-8
#sudo update-locale LANG=pt_BR.UTF-8

# Atualizando o relógio para o horário de São Paulo
sudo timedatectl set-timezone America/Sao_Paulo

# Configurando o teclado para ABNT2
#sudo apt install -y console-common
#sudo loadkeys br-abnt2
#echo 'XKBLAYOUT="br"' | sudo tee -a /etc/default/keyboard
#echo 'XKBVARIANT="abnt2"' | sudo tee -a /etc/default/keyboard
#sudo dpkg-reconfigure --frontend=noninteractive keyboard-configuration

# Reiniciando para aplicar as mudanças
#sudo reboot
