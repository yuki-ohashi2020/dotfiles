#!/bin/bash

# このスクリプト自体のハッシュが変わった時だけ実行される

echo "⚙️  macOSのシステム設定を最適化しています..."

# キーのリピート速度を最速に設定
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 12
defaults write -g ApplePressAndHoldEnabled -bool false

# Macのアプリからのファイル指定はFinderを使用することを強制させられている
# つまり、代替ツールを指定することができない
# そのため、Finderの設定をカスタマイズして使いやすくしている

# Finder: 新規ファインダーのデフォルトのパスをホームディレクトリにする
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# Finder: 拡張子を常に表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder: 隠しファイルを表示
defaults write com.apple.finder AppleShowAllFiles -bool true
# Finder: フォルダを先に表示
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# Finder: リスト形式で表示(.DS_storeの表示履歴が優先される)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Finder: ステータスバーを表示(Finderウィンドウの最下部)
defaults write com.apple.finder ShowStatusBar -bool true
# Finder: パスバーを表示
defaults write com.apple.finder ShowPathbar -bool true
# Finder: タブバーを表示
defaults write com.apple.finder ShowTabView -bool true
# Finder: 検索のデフォルトを開いているフォルダではなく、ディスク全体で検索する
defaults write com.apple.finder FXDefaultSearchScope -string "SCev"
# Finder: デスクトップにボリュームを表示しない
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false


# スクロールの方向を従来型にする
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# スクロール速度(数値が大きいほど早い)
defaults write NSGlobalDomain com.apple.scrollwheel.scaling -float 1.5
# 軽快スクロール（滑らかに）
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool true
# アニメーションを最小化して即時スクロールさせる（画像などが多いサイトでもスムーズにスクロールできる）
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# マウス加速を無効化
defaults write .GlobalPreferences com.apple.mouse.scaling -1


# スクリーンショットの保存先を ~/Downloads/Screenshots に変更
mkdir -p ~/Downloads/Screenshots
defaults write com.apple.screencapture location ~/Downloads/Screenshots
# スクリーンショットの影を消す
defaults write com.apple.screencapture disable-shadow -bool true

# .DS_Storeのネットワークドライブへの作成を禁止
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# .DS_Storeの外部ストレージへの作成を禁止
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# アプリケーション終了時の確認ダイアログを無効化
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# ファイルをゴミ箱に入れる前の確認を無効化
defaults write com.apple.finder WarnOnEmptyTrash -bool false
# 30日経ったゴミ箱のファイルを自動削除する設定を有効化
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# 西暦の週の始まりを月曜(2)に設定
# (1が日曜、2が月曜、7が土曜)
defaults write NSGlobalDomain AppleFirstWeekday -dict "gregorian" 2
# 24時間表記にする
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# Dockの自動表示を非表示にする
defaults write com.apple.dock autohide -bool true
# Dock表示の待機時間を約16分にする
# 実質、Dockを使わない
defaults write com.apple.dock autohide-delay -float 1000


# ホットコーナーを使用しない
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-br-corner -int 0

# ロック画面での通知プレビューを「常にオフ」にする
defaults write com.apple.notificationcenterui "show-previews" -int 0
# ロック画面での通知を「常にオフ」にするs
defaults write com.apple.ncprefs "lock-screen-notifications" -bool false
# ディスプレイがスリープ中に通知で画面が点灯するのをオフにする
defaults write com.apple.notificationcenterui "at-login" -bool false

# 設定を反映するために必要なアプリを再起動
killall Finder
killall Dock
killall cfprefsd
killall NotificationCenter
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