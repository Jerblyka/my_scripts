#!/bin/bash

# Certifique-se de que o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute como root."
  exit 1
fi

# Variáveis
FIREFOX_URL="https://download.mozilla.org/?product=firefox-latest&os=linux&lang=pt-BR"
INSTALL_DIR="/opt/firefox"
BIN_LINK="/usr/bin/firefox"
DESKTOP_FILE="/usr/share/applications/firefox.desktop"

echo "Baixando o Firefox mais recente..."
wget -O firefox.zip "$FIREFOX_URL"

echo "Extraindo o Firefox..."
tar -xzf firefox.zip

echo "Movendo o Firefox para $INSTALL_DIR..."
if [ -d "$INSTALL_DIR" ]; then
  rm -rf "$INSTALL_DIR"
fi
mv firefox "$INSTALL_DIR"

echo "Criando link simbólico em $BIN_LINK..."
if [ -L "$BIN_LINK" ]; then
  rm "$BIN_LINK"
fi
ln -s "$INSTALL_DIR/firefox" "$BIN_LINK"

echo "Criando atalho no menu de aplicativos..."
cat > "$DESKTOP_FILE" <<EOL
[Desktop Entry]
Name=Firefox
Comment=Navegador Web Firefox
Exec=/usr/bin/firefox
Icon=/opt/firefox/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
Categories=Network;WebBrowser;
EOL

echo "Habilitando atualizações automáticas do Firefox..."
# O Firefox já tem atualização automática integrada, então nenhuma ação adicional é necessária.
# Apenas garantimos permissões de escrita.
chmod -R u+w "$INSTALL_DIR"

# Limpeza de arquivos temporários
echo "Limpando arquivos temporários..."
rm firefox.zip

echo "Verificando a instalação..."
firefox --version

echo "Instalação concluída com sucesso! O Firefox está configurado para atualizar automaticamente."
