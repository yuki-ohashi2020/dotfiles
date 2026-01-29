######################################
# history
######################################
# ! ToDo
# BTTで←ctrl+rで履歴からの絞り込み
# 右のctrlでは発火させないこと
mkdir -p "$HOME/.local/share/zsh"
HISTFILE="$HOME/.local/share/zsh/zsh_history"

# memory save num
HISTSIZE=100000
# HISTFILE save num
SAVEHIST=100000
# command of history duplication ignore
setopt hist_ignore_all_dups
# command of <Space>command ignore
setopt hist_ignore_space
# start to end timestanp
setopt extended_history
# reduce blanks  ls   -l => ls -l
setopt hist_reduce_blanks
setopt inc_append_history
setopt hist_save_no_dups
