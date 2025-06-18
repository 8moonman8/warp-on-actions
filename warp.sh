#!/bin/bash

# Установка необходимых компонентов
sudo apt update -y
sudo apt install -y curl wireguard-tools

# Скачать последнюю рабочую версию wgcf с GitHub
curl -s https://api.github.com/repos/ViRb3/wgcf/releases/latest \
| grep "browser_download_url.*linux_amd64" \
| cut -d '"' -f 4 \
| xargs curl -Lo wgcf.tar.gz

tar -xzf wgcf.tar.gz
chmod +x wgcf
sudo mv wgcf /usr/local/bin/

# Генерация конфигурации
wgcf register --accept-tos
wgcf generate

# Настройка конфигурации для использования Warp
sed -i 's/engage.cloudflareclient.com/162.159.193.10/' wgcf-profile.conf

# Переместим конфиг в артефакты GitHub
mkdir -p output
cp wgcf-profile.conf output/wireguard-warp.conf

