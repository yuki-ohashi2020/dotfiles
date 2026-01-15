#!/bin/bash
# .envrc の中身が変わったときだけ、このスクリプトが走る
# {{ include "dot_envrc" | sha256sum }}

echo "🔄 .envrc の変更を検知しました。direnv を自動承認します..."
direnv allow {{ .chezmoi.homeDir }}