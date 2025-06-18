#!/bin/bash

# Установка необходимых компонентов
sudo apt update -y
sudo apt install -y curl wireguard-tools

# Скачать последнюю рабочую версию wgcf с официального GitHub
curl -Lo wgcf.tar.gz https://github.com/ViRb3/wgcf/releases/latest/download/wgcf_amd64_linux.tar.gz
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
