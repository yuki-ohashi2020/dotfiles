return
######################################
# other
######################################
# ! Todo
# - vim likeのインターフェースがあること
# vim like
bindkey -v
bindkey 'jj' vi-cmd-mode
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char
# back ground job state notice
setopt notify
setopt no_beep
# command spell correct
setopt correct
# ^Dでzshを終了しない
setopt ignore_eof
# ^Q/^Sのフローコントロールを無効
setopt no_flow_control
# vimで<C-q>や<C-s>を使えるようにする
stty -ixon -ixoff

######################################
# fancy-ctrl-z
# fgを<C-z>におきかえたもの
######################################
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

######################################
# peco history参照
######################################
# control + r
# .zsh_historyからコマンド履歴をインタラクティブに検索する
bindkey '^r' peco-select-history
zle -N peco-select-history
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
