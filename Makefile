ENV_FILE=$(HOME)/.config/shell/global.env
include $(ENV_FILE)

export PATH := $(BREW_PATH):$(PATH)

# pyenvの保存先(pyenv install)を指定
# export PYENV_ROOT := $(HOME)/$(PYENV_DIR_NAME)
export PATH := $(PYENV_PATH):$(PATH)

SCRIPT_DIR := setup_scripts

help:
	cat ./Makefile

setup:
	$(SCRIPT_DIR)/brew_setup.sh
	$(SCRIPT_DIR)/os_default_setup.sh
	$(SCRIPT_DIR)/dns_setup.sh
	$(SCRIPT_DIR)/python_setup.sh
	$(SCRIPT_DIR)/ssh_setup.sh

dump:
	@echo "管理パッケージをdumpします..."
	brew bundle dump --force --describe --file ./Brewfile
