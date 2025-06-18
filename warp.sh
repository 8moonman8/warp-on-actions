#!/bin/bash

# Установка необходимых компонентов
sudo apt update -y
sudo apt install -y curl wireguard-tools

# Получение Warp+ аккаунта через wgcf
curl -fsSL https://github.com/ViRb3/wgcf/releases/download/v2.2.16/wgcf_2.2.16_linux_amd64.tar.gz | tar xz
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
