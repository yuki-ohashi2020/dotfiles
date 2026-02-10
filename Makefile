# * 環境構築スクリプト
# 	- 動作環境に必要な設定を行う
#
# ! 対象範囲
#	- ツール一式のインストール
#	- OSやネットワークのデフォルト設定
#	- ssh key の生成
#
# ! 運用ルール
#	- Makefileはzshで実行する( zshenv を使いたいため)
#	- シェルスクリプトで setup を行う( 初回実行時はPythonなど言語の設定がされていないため)

# zshの非ログインシェルで実行( zshenv のみ読み込まれる)
SHELL := /bin/zsh
# エラーが発生したら処理をストップさせる
.SHELLFLAGS := -eu -o pipefail -c
# setup用のscript
SCRIPT_PATH := setup_scripts

help:
	cat ./Makefile

setup:
	echo "🔑 管理者権限を確認します..."
	sudo -v
	make setup_network
	make setup-energy
	$(SCRIPT_PATH)/brew_setup.sh
	$(SCRIPT_PATH)/os_default_setup.sh
	$(SCRIPT_PATH)/python_setup.sh
	$(SCRIPT_PATH)/ssh_setup.sh
	make setup-zsh
	@echo "✅: Setup 完了"
	@echo "ログインシェルをzshに変更してください"
	@echo "chsh -s /bin/zsh"

setup-network:
	$(SCRIPT_PATH)/setup_network.sh

setup-energy:
	$(SCRIPT_PATH)/setup_energy.sh

setup-zsh:
	$(SCRIPT_PATH)/zsh_setup.sh

dump:
	@echo "管理パッケージをdumpします..."
	brew bundle dump --force --describe --file ./Brewfile
