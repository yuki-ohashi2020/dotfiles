# ---------------------------------------------------------------------
# リスト表示
# ---------------------------------------------------------------------
alias ls='eza -a --group-directories-first --icons'
alias ll='eza -lAh --group-directories-first --icons --git --time-style=long-iso'
alias lt='eza -la --tree --icons -L 2'
alias tree='lt'
# list copy: リスト表示をターミナルに表示させたうえでクリップボードコピーする
alias lc='eza -1a --group-directories-first | tee /dev/tty | pbcopy'
