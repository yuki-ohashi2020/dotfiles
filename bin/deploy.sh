#!/bin/bash

set -e
cd "$SOURCE_DIR"

if [ -n "$(git status --porcelain)" ]; then
    echo "🚀 Changes detected. Pushing to GitHub..."
    NOW="$(date '+%Y-%m-%d %H:%M:%S')"

    git add .
    git commit -m "auto commit: $NOW"
    git push origin main
else
    echo "✨ No changes to sync."
fi