.PHONY: help apply diff

help:
	cat Makefile

apply:
	chezmoi re-add
	chezmoi apply -v

diff:
	chezmoi diff
