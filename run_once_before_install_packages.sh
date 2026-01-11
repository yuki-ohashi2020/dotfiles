#!/bin/bash

# ホームディレクトリに展開する前に実行されるスクリプト
exit
/bin/bash -c "$(curl -fsLS get.chezmoi.io)" -- init --apply yuki-ohashi2020/dotfiles


exit






