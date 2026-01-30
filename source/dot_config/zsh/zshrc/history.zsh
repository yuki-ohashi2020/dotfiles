# ---------------------------------------------------------------------
# コマンド履歴
# ---------------------------------------------------------------------

mkdir -p "$DATA_ZSH_PATH"
HISTFILE="$DATA_ZSH_PATH/zsh_history"

# メモリに置く履歴件数
HISTSIZE=100000
# ファイルに置く履歴件数
SAVEHIST=100000

# 複数のターミナル間で履歴をリアルタイム共有する
setopt share_history

# コマンドを入力後にすぐに履歴に書き込む
setopt inc_append_history
# 実行日付のフォーマット
HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
# コマンドの実行日時を記録する
setopt extended_history

# 履歴に重複を含めない
setopt hist_ignore_all_dups
# 重複した古い履歴は新しい履歴と交換される
setopt hist_save_no_dups
# historyコマンドを履歴に残さない
setopt hist_no_store
# 余計なスペースを削除して保存する
setopt hist_reduce_blanks

# コマンドの先頭に <Space> をつけると履歴に含めない
#   - 履歴に残したくないAPIキーなどを入力する時に使う
setopt hist_ignore_space


# ---------------------------------------------------------------------
# * fzf
#   - @see https://github.com/junegunn/fzf
# ---------------------------------------------------------------------

# 行番号を表示しない
export FZF_CTRL_R_OPTS="--with-nth=2.."

# 履歴検索の画面の見た目の設定
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --inline-info
  --preview "echo {2..}" --preview-window down:3:wrap
'

source <(fzf --zsh)
# 履歴検索
bindkey '^r' fzf-history-widget
