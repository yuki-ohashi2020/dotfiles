# ---------------------------------------------------------------------
# CLI (コマンド ライン インターフェイス) の編集
# ---------------------------------------------------------------------

# ビープ音をオフ
setopt no_beep
# ^Dでzshを終了しない
setopt ignore_eof
# ^Q/^Sのフローコントロールを無効
setopt no_flow_control

# vim like
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
# 1文字削除
bindkey -M viins '^H' backward-delete-char

# TODO: zsh-vi-mode プラグインを入れる
