# cd /home => /home cd ../ => ..
# setopt auto_cd
# dirctory of stack push cd -<Tab>
setopt auto_pushd
# directory of stack duplication ignore
setopt pushd_ignore_dups

unsetopt auto_cd


######################################
# hash
# ディレクトリのエイリアスを登録できる
######################################

# 前のディレクトリに戻るのを楽にする
alias b='cd -'

############################################################################
# zoxide
############################################################################
# zoxide を cd で起動する
# 効かない_ZO_CMD_PREFIX
export _ZO_CMD_PREFIX="cd"

# zi の見た目の設定
export _ZO_FZF_OPTS="
  --height=50%
  --reverse
  --border=sharp
  --delimiter '\s+'
  --preview='eza -T -L 2 --color=always --icons {2..}'
  --preview-window=right:60%:wrap
"

eval "$(zoxide init zsh)"

# alias cd='__zoxide_z'
alias cdl='zoxide query -l'
alias cdi='zi'

# CDABLE_VARSを指定することで、~を省略できる
# cd ~log => cd log
#setopt CDABLE_VARS
# hash -d d=$CHEZMOI_PATH
cd() {
  if [[ "$1" == "dot" ]]; then
    builtin cd "$CHEZMOI_PATH"
    return
  fi

  __zoxide_z "$@"
}
######################################
# directory
######################################
# ! ToDo
# - zoxide を cdで使えること
# - ctrl+Dとかで移動したディレクトリの履歴を絞り込めること
# - cd の後に移動したファイルの一覧を表示すること
