# ---------------------------------------------------------------------
# ディレクトリ移動
# ---------------------------------------------------------------------

# ディレクトリの移動履歴を記録する
setopt auto_pushd
# 重複したディレクトリの移動履歴は保存しない
setopt pushd_ignore_dups


# ---------------------------------------------------------------------
# * zoxide
#   - @see https://github.com/ajeetdsouza/zoxide
#
# ! 運用ルール
#   - builtin の cd を zoxide に置き換えて使用する
# ---------------------------------------------------------------------

# よく移動するディレクトリ一覧の見た目の設定
export _ZO_FZF_OPTS="
  --height=50%
  --reverse
  --border=sharp
  --delimiter '\s+'
  --preview='eza -T -L 2 --color=always --icons {2..}'
  --preview-window=right:40%:wrap
"
# よく移動するディレクトリ一覧
alias cdi='zi'

eval "$(zoxide init zsh)"

# cd dot        -> Dotfilesに移動する
# cd dot以外    -> zoxideで移動する
cd() {
  if [[ "$1" == "dot" ]]; then
    builtin cd "$CHEZMOI_PATH"
    return
  fi

  __zoxide_z "$@"
}
