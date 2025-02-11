#!/bin/bash

# Atualizando os repositórios e o sistema
sudo apt update && sudo apt full-upgrade -y

# Instalando os pacotes
sudo apt install -y locales console-common ksnip vlc psensor gnome-system-monitor default-jre bluedevil streamlink mpv ffmpeg chrony htop qbittorrent

# Configurando o sistema para PT-BR
sudo locale-gen pt_BR.UTF-8
sudo update-locale LANG=pt_BR.UTF-8

# Atualizando o relógio para o horário de São Paulo
sudo timedatectl set-timezone America/Sao_Paulo

# Configurando o teclado para ABNT2
sudo loadkeys br-abnt2
echo 'XKBLAYOUT="br"' | sudo tee -a /etc/default/keyboard
echo 'XKBVARIANT="abnt2"' | sudo tee -a /etc/default/keyboard
sudo dpkg-reconfigure --frontend=noninteractive keyboard-configuration
