#!/bin/bash

# Defina o diretório onde os wallpapers estão armazenados
wallpaperDir="/home/narayansilva//Github/biglinux-wallpapers-gnome/usr/share/wallpapers"

# Defina o arquivo de saída XML
outputXml="biglinux-gnome.xml"

# Início do arquivo XML
echo '<?xml version="1.0" encoding="UTF-8"?>' > "$outputXml"
echo '<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">' >> "$outputXml"
echo '<wallpapers>' >> "$outputXml"

# Função para converter string para título
toTitleCase() {
    # Remove a extensão do arquivo e substitui traços por espaços
    local nameWithoutExtension="${1%.*}"
    local nameWithSpaces="${nameWithoutExtension//-/ }"

    # Converte para título
    echo "$nameWithSpaces" | awk '{for (i=1; i<=NF; i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2));}1'
}

# Loop pelos arquivos de wallpaper no diretório
for wallpaper in "$wallpaperDir"/*; do
    # Obtenha apenas o nome do arquivo
    filename=$(basename "$wallpaper")

    # Formate o nome para o formato desejado
    formattedName=$(toTitleCase "$filename")

    # Adicione a entrada para este wallpaper no arquivo XML
    echo '  <wallpaper deleted="false">' >> "$outputXml"
    echo "    <name>$formattedName</name>" >> "$outputXml"
    echo "    <filename>/usr/share/wallpapers/$filename</filename>" >> "$outputXml"
    echo '    <options>stretched</options>' >> "$outputXml"
    echo '    <pcolor>#ffffff</pcolor>' >> "$outputXml"
    echo '    <scolor>#000000</scolor>' >> "$outputXml"
    echo '    <shade_type>solid</shade_type>' >> "$outputXml"
    echo '  </wallpaper>' >> "$outputXml"
done

# Final do arquivo XML
echo '</wallpapers>' >> "$outputXml"

# Verifica se o arquivo foi criado com sucesso
if [ -f "$outputXml" ]; then
    echo -e "\033[32mXML gerado com sucesso: $outputXml\033[0m"
else
    echo -e "\033[31mErro ao gerar o arquivo XML.\033[0m"
fi
