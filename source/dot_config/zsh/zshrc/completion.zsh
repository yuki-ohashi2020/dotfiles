######################################
# complete
######################################
# 補完を有効にする

autoload -Uz compinit
# ! ToDo
# - タブで補完されること
# - 部分的に一致している部分まで補完してくれること
# - zsh-autosuggestions
# brew install zsh-autosuggestions
# 補完のキャッシュファイル
ZSH_COMP_DUMP="${LOCAL_CACHE_PATH}/zsh/zcompdump"
mkdir -p "${ZSH_COMP_DUMP:h}"

# ! 一旦、-Cでキャッシュを毎回生成させている
compinit -C -d "$ZSH_COMP_DUMP"
setopt auto_list       # 補完候補が複数ある時に自動でリストを表示
setopt auto_menu       # 2回目のTabでメニュー選択モードに入る
setopt correct

# 補完候補に常にドットファイル（.から始まるファイル）を表示する
# これを書くと "vim ." の後にTabを叩いた時、隠しファイルが出てきます
setopt glob_dots

# Tab で候補一覧を表示して選択
zstyle ':completion:*' menu select
# 部分一致を許可
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'r:|[._-]=* r:|=*'

zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' group-name ''
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' special-dirs false

zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:descriptions' format '%F{blue}--- %d ---%f'

# 補完ミスを修正する (多少のタイポなら補完してくれる)
zstyle ':completion:*' completer _complete _approximate

# --- 中略 (compinit などの設定) ---

source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# bindkey '^I' autosuggest-accept # ctrl提案を受け入れる

###############################################################################
source "$(brew --prefix)/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh"
# 3. fzf-tab の見た目カスタマイズ (お好みで)
# 補完候補のプレビューを表示する設定（例：ディレクトリの中身を見せる）
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'
zstyle ':fzf-tab:*' fzf-command fzf

# 補完系では最後に読み込まないとだめ
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
return


# zsh-completions (外部リポジトリ): compinit 標準ではカバーしていない多くのコマンド（docker, gitの細かいサブコマンド等）の補完定義を追加します。
#zsh-autosuggestions: 入力中に「履歴から薄く補完候補を出す」機能。これは compinit とは別の仕組みですが、爆速で入力できます。
# fzf-tab: これが今一番のトレンドです。 compinit の補完候補を fzf で選択できるようにするプラグインで、ボスがToDoに書いていた「候補を絞り込めること」を最高レベルで実現します。



if [ -x "$(command -v just)" ]; then
    source <(just --completions zsh)
fi
