# ---------------------------------------------------------------------
# コマンド履歴
# ---------------------------------------------------------------------

mkdir -p "$DATA_ZSH_PATH"
HISTFILE="$DATA_ZSH_PATH/zsh_history"

# メモリに置く履歴件数
HISTSIZE=100000
# ファイルに置く履歴件数
SAVEHIST=100000

# 履歴検索に Atuin を使用するときのオプション
#   - Atuin と設定が競合するためオプションを切る
#   - zsh の標準ヒストリーを使用する場合はsetoptにすること
atuin_options() {
    # 複数のターミナル間で履歴をリアルタイム共有する
    unsetopt share_history
    # コマンドを入力後にすぐに履歴に書き込む
    unsetopt inc_append_history
    # コマンドの実行日時を記録する
    unsetopt extended_history
}

atuin_options()

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
# * Atuin
#   - @see https://github.com/atuinsh/atuin
#
# ! 運用ルール
#   - 必ずプラグインの最後にsourceすること
#   - Atuin の ZLE ウィジェットの設定が上書きされる可能性があるため
#   - zsh 標準の履歴検索と置き換えて使用する
# ---------------------------------------------------------------------
eval "$(atuin init zsh)"
# 履歴検索
bindkey '^R' atuin-search

alias hs='atuin search -i'
alias history='atuin search -i'

# history stats
alias hst='atuin stats'
