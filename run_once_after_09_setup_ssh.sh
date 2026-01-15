#!/bin/bash

if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "🔑 SSHキーが見つかりません。生成を開始します..."
    ssh-keygen -t ed25519

    echo "📋 公開鍵をクリップボードにコピーしました。GitHubに登録してください。"
    pbcopy < ~/.ssh/id_ed25519.pub
    open "https://github.com/settings/keys"
fi