#!/bin/bash


echo "⚙️  DNSの設定をします..."

# プライマリー: Cloudflare
# セカンダリー：Google Public DNS
DNS_SERVERS="1.1.1.1 8.8.8.8"

echo "Setting DNS servers to: $DNS_SERVERS"
sudo networksetup -setdnsservers Wi-Fi $DNS_SERVERS

# ネットワークのキャッシュクリア
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# 設定の確認
networksetup -getdnsservers Wi-Fiss