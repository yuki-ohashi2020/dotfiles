# ---------------------------------------------------------------------
# コマンド補完
# ---------------------------------------------------------------------

setopt auto_list        # 補完候補が複数ある時に自動でリストを表示
setopt auto_menu        # 2回目のTabでメニュー選択モードに入る
setopt correct_all      # コマンド名 + 引数をスペルチェックの対象にする

# --- UI (見た目・メニュー・色) ---
zstyle ':completion:*' menu select                             # 矢印キーで選択可能にする
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"        # ファイル種別ごとに色付け
zstyle ':completion:*' verbose yes                             # オプションの説明を表示
zstyle ':completion:*' group-name ''                           # グループ化を有効化
zstyle ':completion:*:descriptions' format '%F{blue}--- %d ---%f' # グループ見出しの装飾
zstyle ':completion:*:messages' format '%F{yellow}%d%f'        # システムメッセージの装飾

# --- 検索ルール (マッチング・許容範囲) ---
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' # 大文字小文字無視・区切り文字補完
zstyle ':completion:*:approximate:*' max-errors 2              # 2文字までのタイポを許容
_comp_options+=(globdots)                                      # ドットファイルを補完対象に入れる

# --- フィルタとソート ---
zstyle ':completion:*' list-dirs-first true                    # ディレクトリを先に表示
zstyle ':completion:*' file-sort modification                  # 新しいファイルを先に表示
zstyle ':completion:*' special-dirs false                      # . と .. は候補に出さない



# ---------------------------------------------------------------------
# * zsh-autosuggestions
#   - @see https://github.com/zsh-users/zsh-autosuggestions
#
# ! 運用ルール
# ---------------------------------------------------------------------
source "$DATA_BREW_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh"

# 補完の提案色(グレー)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
# 提案に必須な最低文字数
ZSH_AUTOSUGGEST_MIN_PREFIX_LENGTH=2
# 提案の検索ルール(履歴 -> 補完候補)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# 提案を受け入れる(行末:end まで補完という意味)
bindkey '^e' autosuggest-accept

###############################################################################
# source "$(brew --prefix)/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh"
# source <(fzf-tab --zsh)

# 3. fzf-tab の見た目カスタマイズ (お好みで)
# 補完候補のプレビューを表示する設定（例：ディレクトリの中身を見せる）
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'
# zstyle ':fzf-tab:*' fzf-command fzf

#source <(just --completions zsh)
