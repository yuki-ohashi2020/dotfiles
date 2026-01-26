# Justはログインシェルの環境変数を引き継いで起動される
# 常にホームディレクトリを基準にコマンドを実行する
# set working-directory := "~"

# chezmoiにパスが通ってなければエラーで終了する
export SOURCE_DIR := `chezmoi source-path`
export TARGET_DIR := `chezmoi target-path`
export LIB_DIR := "$TARGET_DIR/.local/libexec"
export DOTFILES_DIR := `git -C $(chezmoi source-path) rev-parse --show-toplevel`

default:
    @just --list

generate-env:
    chezmoi apply "{{TARGET_DIR}}/.config/shell/global.env"

# find "{{TARGET_DIR}}/.config" -mindepth 1 -maxdepth 1 ! -name 'chezmoi' -exec chezmoi add -r {} \;
[private]
chezmoi-add:
    chezmoi add "{{TARGET_DIR}}/.zshenv"
    chezmoi add "{{TARGET_DIR}}/.editorconfig"
    chezmoi add -r "{{TARGET_DIR}}/.local/bin"
    chezmoi add -r "{{TARGET_DIR}}/.local/libexec"


[private]
git-auto-commit-push:
    @{{LIB_DIR}}/git/auto-commit-push.sh

# 変更の詳細を表示
diff:
    @echo "dotfilesリポジトリとホームディレクトリの差分を表示します..."
    chezmoi status
    chezmoi diff

# 白
TEXT_COLOR := "231"
# 青
BG_COLOR := "24"

[private]
header TEXT:
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    @gum style --foreground {{TEXT_COLOR}} --background {{BG_COLOR}} --bold --padding "2 4" --width 50 --align left "{{TEXT}}"
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

save:
    @just header "Dotfiles Save"
    @echo "From: {{TARGET_DIR}} => To: {{SOURCE_DIR}}"
    just chezmoi-add
    @just header "Git Auto Commit Push"
    pyenv exec python task_scripts/git/auto-commit-push.py --dir {{DOTFILES_DIR}}

[private]
brew-upgrade:
    brew update
    brew upgrade

[private]
nvim-upgrade:
    nvim --headless "+Lazy! sync" +qa

upgrade:
    @just header "Homebrew Plugins Upgrade"
    just brew-upgrade
    @just header "Neovim Plugins Upgrade"
    just nvim-upgrade

