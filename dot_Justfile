set dotenv-load
set fallback := true

SOURCE_DIR := if env_var("SOURCE_DIR") != "" {
    env_var("SOURCE_DIR")
} else {
    error("SOURCE_DIR 環境変数が設定されていません。")
}

default:
    @just --list

dry-run:
    echo "実行スクリプトの順序check"
    chezmoi apply --dry-run --verbose

setup:
    echo "初期セットアップを実行します..."
    chezmoi apply -v

diff:
    echo "更新対象"
    chezmoi status
    echo "更新詳細"
    chezmoi diff

upgrade:
    echo "brewと管理パッケージを更新します..."
    brew update
    brew upgrade

dump:
    @echo "管理パッケージをdumpします..."
    brew bundle dump --force --describe --file "$(SOURCE_DIR)/Brewfile"
