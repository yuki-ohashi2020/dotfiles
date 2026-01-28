#!/bin/bash

PYTHON_VERSION=3.12.2

#  pyenv コマンドにパスが通っているか確認
if ! command -v pyenv >/dev/null 2>&1; then
  echo "Error: Pyenv is not installed or not in your PATH." >&2
  exit 1
fi

# -s インストール済みの場合はスキップ
pyenv install -s "$PYTHON_VERSION"
pyenv global "$PYTHON_VERSION"
