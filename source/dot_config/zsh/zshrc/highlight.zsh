# ---------------------------------------------------------------------
# ハイライト
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# * zsh-syntax-highlighting
#   - @see https://github.com/zsh-users/zsh-syntax-highlighting
#
# ! 運用ルール
#   - 必ずプラグインの最後にsourceすること
#   - ハイライト完了後に再度、補完が適用されると色付けが消えるため
# ---------------------------------------------------------------------
source "$DATA_BREW_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# 🟢 実在するコマンドの入力時
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
# 🔴 実在しないコマンドの入力時
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'

# 🟣 コマンドのオプション(実在しないオプションのカラーは設定できない)
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=magenta'

# 🔵 パス(実在しないパスのカラーは設定できない)
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=cyan'

# 🟡 クォート(''/"")で囲った文字列
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
