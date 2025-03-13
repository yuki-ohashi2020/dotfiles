# dotfilesディレクトリがなければ作成
[[ -d ${HOME}/dotfiles ]] || git clone git@github.com:hamuhamu/dotfiles.git ${HOME}/dotfiles


# ドットファイルをホームディレクトリにシムリンクを貼る
for i in `ls -a`
do
    [[ -f ${HOME}/dotfiles/$i ]] || continue # ファイル以外ならcontinue
    [[ $i =~ ^\..*$ ]] || continue           # .から始まるファイルでなければcontinue

    ln -sf ${HOME}/dotfiles/$i ${HOME}
done

#######################################################################
# binの設定
#######################################################################
mkdir -p ${HOME}/bin
ln -sf ${HOME}/dotfiles/bin/* ${HOME}/bin

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

if [ `uname` = "Darwin" ]; then
    uname
    # Mac OS X用の設定

    # brewがinstallされていなければ、インストールする
    which brew
    if [ $? -eq 1 ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    chsh -s /bin/zsh

    chmod 755 /usr/local/share/zsh/site-functions
    chmod 755 /usr/local/share/zsh
fi

./recipe.sh
