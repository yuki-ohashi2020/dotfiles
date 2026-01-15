#!/bin/bash

set -e
# dotfilesのディレクトリに移動
cd "$CHEZMOI_SOURCE_DIR"
# ここでGit操作を行う
if [ -n "$(git status --porcelain)" ]; then
    echo "🚀 Changes detected. Pushing to GitHub..."
    NOW="$(date '+%Y-%m-%d %H:%M:%S')"

    git add .
    git commit -m "auto commit: $NOW"
    git push origin main
else
    echo "✨ No changes to sync."
fi