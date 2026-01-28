#!/bin/bash

# * 環境構築スクリプト
#   - 環境構築時の1度のみ使用される
#   - bash シェルで起動される
#
# ! 対象範囲
#   - dotfilesリポジトリを扱うための最低限のツールのインストール
#   - 具体的なsetupはdotfiles/Makefileで行う

set -eu

echo "🚀 Bootstrapping your Mac..."

# 1. Xcode Command Line Tools のインストール
# すでにインストールされているか確認
if ! xcode-select -p &>/dev/null; then
    echo "📦 Installing Xcode Command Line Tools..."
    # インストールを開始（ダイアログが出るので、完了するまで待機が必要です）
    xcode-select --install

    echo "⚠️  Please complete the Xcode Command Line Tools installation dialog before continuing."
    echo "Press any key when installation is finished..."
    read -n 1 -rlse
else
    echo "✅ Xcode Command Line Tools is already installed."
fi

# 2. Homebrew のインストール
if ! command -v brew &>/dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # brewのパスを通す
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "✅ Homebrew is already installed."
fi

# 3. chezmoi のインストールと初期化
if ! command -v chezmoi &>/dev/null; then
    echo "🏠 Installing chezmoi..."
    brew install chezmoi
fi

if [ ! -d "$HOME/.local/share/chezmoi" ]; then
    echo "✨ Initializing chezmoi..."
    chezmoi init yuki-ohashi2020/dotfiles
else
    echo "✅ chezmoi is already initialized."
fi

echo "🎉 Bootstrap complete."
echo "🎉 Next 'make setup'"
