source $HOME/dotfiles/.zprofile.antigen

export SVN_EDITOR=vim

# /usr/localを最優先で読み込み
export PATH=/usr/local:$PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.composer/vendor/bin
# https://github.com/riywo/anyenv
export PATH=$HOME/.anyenv/bin:$PATH

# anyenv
if [ -d $HOME/.anyenv ] ; then
    export PATH=$HOME/.anyenv/bin:$PATH
    eval "$(anyenv init -)"
fi

# .zprofile.local
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# 初回シェル時のみ tmux実行
if [ $SHLVL = 1 ]; then
  tmux
fi

# .zshenvに以下の設定を記述しておくとプロファイリングしてくれる
# zmodload zsh/zprof && zprof
if (which zprof > /dev/null) ;then
      zprof | less
fi

# Setting PATH for Python 3.10
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH
