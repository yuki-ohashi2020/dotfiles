#!/bin/bash

# ---------------------------------------------------------------------
# ネットワーク
#
# ! 運用ルール
#   - DNSの設定のみ行う
#   - プロバイダDNSではなく公開DNSを使用する
#   - 公開DNSを使用する理由はセキュリティなどの仕様が明示されているため
# ---------------------------------------------------------------------
echo "⚙️ DNSの設定を行います..."

SERVICE="Wi-Fi"
DNS=("1.1.1.1" "8.8.8.8")

sudo networksetup -setdnsservers "$SERVICE" "${DNS[@]}"

echo "🧹 ネットワークキャッシュをクリアします..."
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

echo "🔍 DNSの設定確認:"
networksetup -getdnsservers "$SERVICE"
