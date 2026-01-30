######################################
# complete
######################################
# 補完を有効にする

setopt auto_list       # 補完候補が複数ある時に自動でリストを表示
setopt auto_menu       # 2回目のTabでメニュー選択モードに入る

# 補完候補に常にドットファイル（.から始まるファイル）を表示する
# これを書くと "vim ." の後にTabを叩いた時、隠しファイルが出てきます
setopt glob_dots

# Tab で候補一覧を表示して選択
zstyle ':completion:*' menu select
# 部分一致を許可
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'r:|[._-]=* r:|=*'


# 24時間に1回だけ dumpファイルを更新する（起動高速化）
for dump in ~/.zcompdump(N.m-24); do
#  compinit
done
if [[ ! -f ~/.zcompdump ]]; then
#  compinit
fi
# zsh-completions (外部リポジトリ): compinit 標準ではカバーしていない多くのコマンド（docker, gitの細かいサブコマンド等）の補完定義を追加します。
#zsh-autosuggestions: 入力中に「履歴から薄く補完候補を出す」機能。これは compinit とは別の仕組みですが、爆速で入力できます。
# fzf-tab: これが今一番のトレンドです。 compinit の補完候補を fzf で選択できるようにするプラグインで、ボスがToDoに書いていた「候補を絞り込めること」を最高レベルで実現します。

# 補完関数の読み込みパス追加（もし自前で持っている場合）
# ここが更新されたらcompinitで読まれる
fpath=(~/.zsh/completions $fpath)

# ! プラグインマネージャを導入すること
# fast-syntax-highlighting を読み込む
# ! fast-syntax-highlightingを使わないなら削除すること
# source "${BREW_PLUGIN_DIR}/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# 色設定
typeset -A FAST_HIGHLIGHT_STYLES

FAST_HIGHLIGHT_STYLES[unknown-token]='fg=196,bold'      # 存在しないコマンド：明るい赤+太字
FAST_HIGHLIGHT_STYLES[command]='fg=040'                # 存在するコマンド：標準的な緑
FAST_HIGHLIGHT_STYLES[alias]='fg=045'                  # エイリアス：明るい水色
FAST_HIGHLIGHT_STYLES[path]='fg=220,underline'         # パス：黄色+下線
FAST_HIGHLIGHT_STYLES[single-hyphen-option]='fg=208'   # -オプション：オレンジ
FAST_HIGHLIGHT_STYLES[double-hyphen-option]='fg=208'   # --オプション：オレンジ

# 描画負荷対策
FAST_HIGHLIGHT_BUFFER_MAX_LINES=1000
################################################################################################################

autoload -Uz compinit
# ! ToDo
# - タブで補完されること
# - 部分的に一致している部分まで補完してくれること
# - zsh-autosuggestions
# - もしかして機能
# - 存在しないコマンドは入力中に色で教えてくれること
# brew install zsh-autosuggestions
# 補完のキャッシュファイル
ZSH_COMP_DUMP="${LOCAL_CACHE_PATH}/zsh/zcompdump"
mkdir -p "${ZSH_COMP_DUMP:h}"

# ! 一旦、-Cでキャッシュを毎回生成させている
compinit -C -d "$ZSH_COMP_DUMP"

if [ -x "$(command -v just)" ]; then
    source <(just --completions zsh)
fi
