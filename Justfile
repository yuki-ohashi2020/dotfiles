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
    @chezmoi apply "{{TARGET_DIR}}/.config/shell/global.env"
    @echo "✅Generated"
    @cat "{{TARGET_DIR}}/.config/shell/global.env"

# 変更の詳細を表示
diff:
    @echo "dotfilesリポジトリとホームディレクトリの差分を表示します..."
    chezmoi status
    chezmoi diff

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

