#!/bin/bash

exit
/bin/bash -c "$(curl -fsLS get.chezmoi.io)" -- init --apply yuki-ohashi2020/dotfiles


exit


#######################################################################
# vimの設定
#######################################################################
mkdir -p ${HOME}/.vim/
mkdir -p ${HOME}/.vim/bundle

# NeoBundleのインストール
if [[ ! -d ${HOME}/.vim/bundle/neobundle.vim ]]; then
    git clone https://github.com/Shougo/neobundle.vim ${HOME}/.vim/bundle/neobundle.vim
    vim -c ':NeoBundleInstall!' -c ':q!'
fi


    # chsh -s /bin/zsh




