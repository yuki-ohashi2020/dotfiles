# Justはログインシェルの環境変数を引き継いで起動される
# 常にホームディレクトリを基準にコマンドを実行する

TARGET_DIR := `chezmoi target-path`
SOURCE_DIR := `chezmoi source-path`
DOTFILES_PATH := env_var("CHEZMOI_PATH")
SCRIPT_PATH  := DOTFILES_PATH + "/task_scripts"
PYTHON := `pyenv which python`

# コマンド一覧
default:
    @just --list

# デバッグ
debug:
    @echo "Dotfiles: {{DOTFILES_PATH}}"
    @echo "Scripts:  {{SCRIPT_PATH}}"

[private]
header TEXT:
    @{{PYTHON}} {{SCRIPT_PATH}}/header.py "{{TEXT}}"

alias st := status
# ステータス( Chezmoi / Git)
status:
    @just header "chezmoi 管理対象外(not add)"
    chezmoi unmanaged
    @just header "Source(左) と Target(右) の差分ステータス "
    @echo "⚠️ status MMの場合: コンフリクトが起きている可能性あり"
    chezmoi status
    @just header "GitリポジトリとSourceの差分ステータス"
    git status

alias ig := ignore
# Chezmoi の 除外ファイルを開く
ignore:
    $EDITOR {{SOURCE_DIR}}/.chezmoiignore

# Chezmoi の更新 & Git auto commit push
save:
    @just header "Dotfiles Save"
    @echo "From: {{TARGET_DIR}} => To: {{SOURCE_DIR}}"
    @chezmoi re-add
    @just header "Git Auto Commit Push"
    @{{PYTHON}} {{SCRIPT_PATH}}/git/auto-commit-push.py --dir {{DOTFILES_PATH}}

[private]
brew-upgrade:
    brew update
    brew upgrade

[private]
nvim-upgrade:
    nvim --headless "+Lazy! sync" +qa

# プラグインの更新( brew / nvim )
upgrade:
    @just header "Homebrew Plugins Upgrade"
    @just brew-upgrade
    @just header "Neovim Plugins Upgrade"
    @just nvim-upgrade

