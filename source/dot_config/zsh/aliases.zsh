############################################################################
# Git
############################################################################
alias g='git'

############################################################################
# エディッター
############################################################################
# ! ToDo
# VIM_EDITORみたいな環境変数をzprofileで設定する
if [ -n "$WARP_IS_LOCAL_SHELL_SESSION" ]; then
    # ターミナルがWarpの場合のみvscodeで起動する
    alias vim='code'
    alias vi='code'
else
    alias vim='nvim'
    alias vi='nvim'
fi

############################################################################
# その他
############################################################################
alias cl='clear'
alias tm='tmux'

# ! ToDo オプションをつける
# s Commandでもいいかも
alias code-search='rg'
# ctrl+r
# コマンドで絞り込むか、コードで絞り込むか、ファイルで絞り込むか

# rg --line-number --column --no-heading --color=always "pattern" | fzf --ansi
# ! ToDo cmd+rでリロードにする
# alias reload="source $HOME/.zprofile"
# ! ToDo 起動時に読み込まれた設定を出力する方が良い
# alias showZenv="cat $HOME/.zshenv"

# ファイルを絞り込んでvimで開く
# vim finderの略
# alias vf="ag -l | peco | xargs -o vim"

# ! ToDo fdコマンド
# bat
# zsh-syntax-highlighting
# fzf
############################################################################
# chezmoi
############################################################################
alias ch='chezmoi'

