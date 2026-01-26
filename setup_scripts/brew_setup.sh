#!/bin/bash

# brew コマンドにパスが通っているか確認
if ! command -v brew >/dev/null 2>&1; then
  echo "Error: Homebrew の PATH が通っていません" >&2
  exit 1
fi

# パッケージの追加のみでcleanup(同期的削除)はしない
brew bundle --file="./Brewfile"
