# dotfilesディレクトリがなければ作成
[[ -d ${HOME}/dotfiles ]] || git clone git@github.com:yuki-ohashi2020/dotfiles.git ${HOME}/dotfiles


# ドットファイルをホームディレクトリにシムリンクを貼る
for i in `ls -a`
do
    [[ -f ${HOME}/dotfiles/$i ]] || continue # ファイル以外ならcontinue
    [[ $i =~ ^\..*$ ]] || continue           # .から始まるファイルでなければcontinue

    ln -sf ${HOME}/dotfiles/$i ${HOME}
done

ln -sf ${HOME}/dotfiles/.hammerspoon ${HOME}

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
# brewコマンドにパスが通っているか確認
if ! command -v brew &> /dev/null; then
    echo "Homebrewが見つかりません。インストールを開始します..."

    # Xcode Command Line Toolsのインストール（ダイアログが出るので手動承認が必要）
    xcode-select --install

    # Homebrewのインストール実行
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Apple Silicon Macの場合、パスを通す処理が必要（重要！）
    if [[ "$(uname -m)" == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "Homebrewは既にインストールされています。"
fi

if [ `uname` = "Darwin" ]; then
    uname
    # Mac OS X用の設定

    # brewがinstallされていなければ、インストールする
    which brew
    if [ $? -eq 1 ]; then
        xcode-select --install
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # chsh -s /bin/zsh

    # chmod 755 /usr/local/share/zsh/site-functions
    # chmod 755 /usr/local/share/zsh
fi



# .DS_Storeのネットワークドライブへの作成を禁止
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# .DS_Storeの外部ストレージへの作成を禁止
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
