SHELL := /bin/zsh

# -l (login): .zprofile を読み込んで環境変数やPATHを通す
# -c (command): Makefile の各行をコマンドとして実行する
# ※ .zshrc は非対話モードのため読み込まれない
.SHELLFLAGS := -l -c

# Makefileと同じ階層
SETUP_DIR := $(CURDIR)
help:
	cat "$(SETUP_DIR)/Makefile"


dump:
	@echo "管理パッケージをdumpします..."
	brew bundle dump --force --describe --file "$(SETUP_DIR)/Brewfile"
