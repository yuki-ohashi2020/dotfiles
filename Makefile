.PHONY: help dry-run apply diff

help:
	cat Makefile

dry-run:
	@echo "実行スクリプトの順序check"
	chezmoi apply --dry-run --verbose

apply:
	chezmoi apply -v

diff:
	@echo "更新対象"
	chezmoi status
	@echo "更新詳細"
	chezmoi diff


