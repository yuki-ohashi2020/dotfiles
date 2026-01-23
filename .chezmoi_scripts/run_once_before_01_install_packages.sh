#!/bin/bash
# ホームディレクトリに展開する前に1度だけ実行されるスクリプト

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Apple Silicon Macの場合、インストール直後はパスが通っていないので一時的に通す
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

if [ -f "{{ .chezmoi.sourceDir }}/Brewfile" ]; then
    echo "Installing from Brewfile..."
    brew bundle --global --file="{{ .chezmoi.sourceDir }}/Brewfile"
fi

if [ "$SHELL" != "/bin/zsh" ]; then
    echo "🐚 デフォルトシェルを zsh に変更します..."
    chsh -s /bin/zsh
fi

echo "続けてrun_once_after_系のコマンドを実行します..."