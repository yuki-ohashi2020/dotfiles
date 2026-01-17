#!/bin/bash

# --- README ---
# iCloudにBTTの設定ファイルを丸ごとバックアップを取る
# ----------------

# --- 設定項目 ---
# 1. バックアップ元（BTTのデータフォルダ）
SOURCE_DIR="$HOME/Library/Application Support/BetterTouchTool"
BACKUP_DIR="BTT"
# 2. iCloud内の保存先
# BACKUP_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Backups/BTT"
# 3. 保持する世代数
KEEP_COUNT=5
# 4. バックアップファイル名のプレフィックス
FILE_PREFIX="BTT_Full_Backup"
# 5. バックアップ後のファイル名 (形式: 2026_01_17_07:40:01)
# DATE=$(date +%Y_%m_%d_%H:%M:%S)
# DEST_FILE="$BACKUP_DIR/${FILE_PREFIX}_$DATE.zip"
# ----------------

SOURCE_DIR="$SOURCE_DIR" \
BACKUP_DIR="$BACKUP_DIR" \
FILE_PREFIX="$FILE_PREFIX" \
KEEP_COUNT="$KEEP_COUNT" \
./icloud_backup.sh