GIT_REPOSITORY="yuki-ohashi2020/dotfiles.git"

FAILED=1

TARGET_UNAME="arm64"
YOUR_UNAME="$(uname -m)"

EXECUTE_PREFIX="🚀 execute:"
FAILED_PREFIX="❌ failed:"

# エラーがあれば即座に中断
set -e

# アーキテクチャのチェック
if [ "$YOUR_UNAME" != "$TARGET_UNAME" ]; then
    echo "$FAILED_PREFIX セットアップ対象外 (Expected: $TARGET_UNAME, Actual: $YOUR_UNAME)"
    echo "your uname: $YOUR_UNAME"

    exit "$FAILED"
fi

# brew inslallを使用するためにxcodeのインストールチェック
if ! xcode-select -p &>/dev/null; then
    echo "$FAILED_PREFIX xcodeがインストールされていません"
    echo "please command: xcode-select --install"

    exit "$FAILED"
fi

if ! command -v brew &> /dev/null; then
    echo "$EXECUTE_PREFIX Homebrewをインストールします"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # インストール直後はパスを通す必要がある
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# chezmoi のインストールと適用
if ! command -v chezmoi &> /dev/null; then
    echo "$EXECUTE_PREFIX chezmoiをインストールします"
    brew install chezmoi
fi

if [ ! -d "$HOME/.local/share/chezmoi" ]; then
    echo "$EXECUTE_PREFIX chezmoiの設定をします"
    chezmoi init --apply "$GIT_REPOSITORY"
fi

echo "✅ すべてのセットアップが完了しました"

exit

# ドットファイルをホームディレクトリにシムリンクを貼る
for i in `ls -a`
do
    [[ -f ${HOME}/dotfiles/$i ]] || continue # ファイル以外ならcontinue
    [[ $i =~ ^\..*$ ]] || continue           # .から始まるファイルでなければcontinue

    ln -sf ${HOME}/dotfiles/$i ${HOME}
done

ln -sf ${HOME}/dotfiles/.hammerspoon ${HOME}


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

    # chmod 755 /usr/local/share/zsh/site-functions
    # chmod 755 /usr/local/share/zsh



# .DS_Storeのネットワークドライブへの作成を禁止
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# .DS_Storeの外部ストレージへの作成を禁止
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
