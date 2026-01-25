#!/bin/bash

# --- README ---
# iCloudにBTTの設定ファイルを丸ごとバックアップを取る
# ----------------

# --- 設定項目 ---
# 1. バックアップ元（BTTのデータフォルダ）
SOURCE_DIR="$HOME/Library/Application Support/BetterTouchTool"
BACKUP_DIR="BTT"
# 保持する世代数
KEEP_COUNT=5
# 4. バックアップファイル名のプレフィックス
FILE_PREFIX="BTT_Full_Backup"
# ----------------

SOURCE_DIR="$SOURCE_DIR" \
BACKUP_DIR="$BACKUP_DIR" \
FILE_PREFIX="$FILE_PREFIX" \
KEEP_COUNT="$KEEP_COUNT" \
./icloud_backup.sh