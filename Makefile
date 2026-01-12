.PHONY: help apply diff

help:
	cat Makefile

apply:
	chezmoi apply -v

diff:
	chezmoi diff
