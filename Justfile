# Justはログインシェルの環境変数を引き継いで起動される
# 常にホームディレクトリを基準にコマンドを実行する

# chezmoiにパスが通ってなければエラーで終了する
export SOURCE_DIR := `chezmoi source-path`
export TARGET_DIR := `chezmoi target-path`
export LIB_DIR := "$TARGET_DIR/.local/libexec"
export DOTFILES_DIR := `git -C $(chezmoi source-path) rev-parse --show-toplevel`

PYTHON := `pyenv which python`

default:
    @just --list

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
    @{{PYTHON}} task_scripts/header.py "Dotfiles Save"
    @echo "From: {{TARGET_DIR}} => To: {{SOURCE_DIR}}"
    @chezmoi re-add
    @pyenv exec python task_scripts/header.py "Git Auto Commit Push"
    @pyenv exec python task_scripts/git/auto-commit-push.py --dir {{DOTFILES_DIR}}

[private]
brew-upgrade:
    brew update
    brew upgrade

[private]
nvim-upgrade:
    nvim --headless "+Lazy! sync" +qa

upgrade:
    @pyenv exec python task_scripts/header.py "Homebrew Plugins Upgrade"
    @just brew-upgrade
    @pyenv exec python task_scripts/header.py "Neovim Plugins Upgrade"
    @just nvim-upgrade

