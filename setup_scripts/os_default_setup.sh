#!/bin/bash

echo "⚙️  macOSのシステム設定を最適化しています..."

# ---------------------------------------------------------------------
# キーリピート
# ---------------------------------------------------------------------
# キーのリピート速度を最速に設定
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 12
defaults write -g ApplePressAndHoldEnabled -bool false


##########################################################################
# スクロール
##########################################################################
# スクロールの方向を従来型にする
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# スクロール速度(数値が大きいほど早い)
defaults write NSGlobalDomain com.apple.scrollwheel.scaling -float 1.5
# 軽快スクロール（滑らかに）
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool true
# アニメーションを最小化して即時スクロールさせる（画像などが多いサイトでもスムーズにスクロールできる）
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false


##########################################################################
# Finder
# ! <制約>
# - 全てのMacアプリはファイルの指定にデフォルトでFiderが使用されている
# - つまり、ファイラーとしてFinderに依存している
# - 2026年時点でFinderから別の使いやすいファイラーに切り替える事はできない
# - そのため、Finderをカスタマイズして使いやすくする
##########################################################################
# 新規ファインダーのデフォルトのパスをホームディレクトリにする
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# 拡張子を常に表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# 隠しファイルを表示
defaults write com.apple.finder AppleShowAllFiles -bool true
# フォルダを先に表示
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# リスト形式で表示(.DS_storeの表示履歴が優先される)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# ステータスバーを表示(Finderウィンドウの最下部)
defaults write com.apple.finder ShowStatusBar -bool true
# パスバーを表示
defaults write com.apple.finder ShowPathbar -bool true
# タブバーを表示
defaults write com.apple.finder ShowTabView -bool true
# 検索のデフォルトを開いているフォルダではなく、ディスク全体で検索する
defaults write com.apple.finder FXDefaultSearchScope -string "SCev"
# デスクトップにマウントしたVolumeを表示させない
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
# .DS_Storeのネットワークドライブへの作成を禁止
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# .DS_Storeの外部ストレージへの作成を禁止
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true


##########################################################################
# スクリーンショット
##########################################################################
# スクリーンショットの保存先を ~/Downloads/Screenshots に変更
mkdir -p ~/Downloads/Screenshots
defaults write com.apple.screencapture location ~/Downloads/Screenshots
# スクリーンショットの影を消す
defaults write com.apple.screencapture disable-shadow -bool true


##########################################################################
# アプリケーション終了時
##########################################################################
# アプリケーション終了時の確認ダイアログを無効化
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false


##########################################################################
# ゴミ箱
##########################################################################
# ファイルをゴミ箱に入れる前の確認を無効化
defaults write com.apple.finder WarnOnEmptyTrash -bool false
# 30日経ったゴミ箱のファイルを自動削除する設定を有効化
defaults write com.apple.finder FXRemoveOldTrashItems -bool true


##########################################################################
# Dock
# ! <運用方針>
# - Dockは使用せずに高機能なアプリスイッチャー(AltTabやRaycastなど)に寄せる
##########################################################################
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


##########################################################################
# ロック画面
##########################################################################
# ロック画面での通知プレビューを「常にオフ」にする
defaults write com.apple.notificationcenterui "show-previews" -int 0
# ロック画面での通知を「常にオフ」にする
defaults write com.apple.ncprefs "lock-screen-notifications" -bool false
# ディスプレイがスリープ中に通知で画面が点灯するのをオフにする
defaults write com.apple.notificationcenterui "at-login" -bool false

##########################################################################
# 設定を反映するために必要なアプリを再起動
##########################################################################
killall Finder
killall Dock
killall cfprefsd
killall NotificationCenter
killall SystemUIServer

echo "✅ macOSの設定が完了しました。"

