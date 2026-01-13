#!/bin/bash

# このスクリプト自体のハッシュが変わった時だけ実行される

echo "⚙️  macOSのシステム設定を最適化しています..."

# キーのリピート速度を最速に設定
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write -g ApplePressAndHoldEnabled -bool false

# Finder: 拡張子を常に表示
defaults write NSGlobalDomain AppleShowAllFiles -bool true
# Finder: リスト表示
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Finder: ステータスバーを表示
defaults write com.apple.finder ShowStatusBar -bool true

# スクリーンショットの保存先を ~/Downloads/Screenshots に変更
mkdir -p ~/Downloads/Screenshots
defaults write com.apple.screencapture location ~/Downloads/Screenshots

# .DS_Storeのネットワークドライブへの作成を禁止
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# .DS_Storeの外部ストレージへの作成を禁止
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# 設定を反映するために必要なアプリを再起動
killall Finder
killall SystemUIServer

echo "✅ macOSの設定が完了しました。"



#######################################################################
# vimの設定
#######################################################################
#mkdir -p ${HOME}/.vim/
#mkdir -p ${HOME}/.vim/bundle

# NeoBundleのインストール
if [[ ! -d ${HOME}/.vim/bundle/neobundle.vim ]]; then
    git clone https://github.com/Shougo/neobundle.vim ${HOME}/.vim/bundle/neobundle.vim
    vim -c ':NeoBundleInstall!' -c ':q!'
fi
