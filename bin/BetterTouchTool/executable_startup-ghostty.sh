#!/bin/bash

# パスの設定
NVIM_PATH="/opt/homebrew/bin/nvim"
TARGET_FILE="$HOME/Working_Note"

# Ghosttyが起動していない場合
if ! pgrep -x "Ghostty" > /dev/null; then
   # Ghosttyを新規起動してnvimで特定ファイルを開く
    open -na Ghostty --args -e zsh -c "$NVIM_PATH '$TARGET_FILE'; exit"
fi
