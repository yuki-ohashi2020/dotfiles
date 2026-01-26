#!/bin/bash

# パスの設定
NVIM_PATH="/opt/homebrew/bin/nvim"
TARGET_FILE="$HOME/Documents/Working_Note"

# Ghosttyが起動していない場合のみ実行
if ! pgrep -q "Ghostty"; then
  # バックグラウンドで起動（最前面に出さない）
  # 表示/非表示の切り替えや表示位置の制御はBTT側で行うこと
  open -jga Ghostty --args -e zsh -c "$NVIM_PATH '$TARGET_FILE'; exit"
fi
