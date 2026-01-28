# Justはログインシェルの環境変数を引き継いで起動される
# 常にホームディレクトリを基準にコマンドを実行する

# chezmoiにパスが通ってなければエラーで終了する
TARGET_DIR := `chezmoi target-path`
SOURCE_DIR := `chezmoi source-path`
DOTFILES_DIR := parent_directory(SOURCE_DIR)
SCRIPTS_DIR  := DOTFILES_DIR + "/task_scripts"

PYTHON := `pyenv which python`

default:
    @just --list

debug:
    @echo "Dotfiles: {{DOTFILES_DIR}}"
    @echo "Scripts:  {{SCRIPTS_DIR}}"

[private]
header TEXT:
    @{{PYTHON}} {{SCRIPTS_DIR}}/header.py "{{TEXT}}"

generate-env:
    @chezmoi apply "{{TARGET_DIR}}/.config/.env/global.env"
    @echo "✅Generated"
    @cat "{{TARGET_DIR}}/.config/.env/global.env"

status:
    @just header "chezmoi 管理対象外(not add)"
    chezmoi unmanaged
    @just header "Source(左) と Target(右) の差分ステータス "
    @echo "⚠️ status MMの場合: コンフリクトが起きている可能性あり"
    chezmoi status
    @just header "GitリポジトリとSourceの差分ステータス"
    git status

ignore:
    $EDITOR {{SOURCE_DIR}}/.chezmoiignore

save:
    @just header "Dotfiles Save"
    @echo "From: {{TARGET_DIR}} => To: {{SOURCE_DIR}}"
    @chezmoi re-add
    @just header "Git Auto Commit Push"
    @{{PYTHON}} {{SCRIPTS_DIR}}/git/auto-commit-push.py --dir {{DOTFILES_DIR}}

[private]
brew-upgrade:
    brew update
    brew upgrade

[private]
nvim-upgrade:
    nvim --headless "+Lazy! sync" +qa

upgrade:
    @just header "Homebrew Plugins Upgrade"
    @just brew-upgrade
    @just header "Neovim Plugins Upgrade"
    @just nvim-upgrade

