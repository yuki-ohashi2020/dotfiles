#!/bin/bash

# ! 対象範囲
#   - Homebrew でインストールできないパッケージの導入

# Powerlevel 10K(プロンプトの表示カスタマイズ)
if [ ! -d "$DATA_P10K_PATH" ]; then
    # 最新のコミット分だけcloneする
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$DATA_P10K_PATH"
fi
