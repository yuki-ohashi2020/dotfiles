.PHONY: help dry-run apply diff

help:
	cat Makefile

dry-run:
	@echo "実行スクリプトの順序check"
	chezmoi apply --dry-run --verbose

apply:
	chezmoi apply -v

diff:
	chezmoi diff


