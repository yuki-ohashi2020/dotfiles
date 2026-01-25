#!/bin/bash

# 1. 必須環境変数の存在チェック
: "${SOURCE_DIR:?環境変数 SOURCE_DIR が設定されていません}"
: "${BACKUP_DIR:?環境変数 BACKUP_DIR が設定されていません}"
: "${KEEP_COUNT:?環境変数 KEEP_COUNT が設定されていません}"
: "${FILE_PREFIX:?環境変数 FILE_PREFIX が設定されていません}"

# 2. 数値バリデーション（ここで弾くので、後の tr 処理は不要）
if [[ ! "$KEEP_COUNT" =~ ^[0-9]+$ ]]; then
    echo "❌ エラー: KEEP_COUNT に不正な値が含まれています ('$KEEP_COUNT')。"
    exit 1
fi

# 3. 定数・パスの定義
ICLOUD_BASE="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
TARGET_DIR="$ICLOUD_BASE/$BACKUP_DIR"
DATE=$(date +%Y_%m_%d_%H:%M:%S)
DEST_FILE="$TARGET_DIR/${FILE_PREFIX}_$DATE.zip"
PATTERN="${FILE_PREFIX}_*.zip"

# バックアップ実行関数
backup() {
    mkdir -p "$TARGET_DIR"
    echo "📦 バックアップ作成中..."
    
    if zip -r "$DEST_FILE" "$SOURCE_DIR" > /dev/null; then
        echo "🚀 完了: $DEST_FILE"
    else
        echo "❌ エラー: バックアップに失敗しました"
        exit 1
    fi
}

# ローテーション実行関数
rotate() {
    local OLD_IFS="$IFS"
    IFS=$'\n'
    
    # 1. ファイル一覧を配列に格納
    local FILES=($(ls -1tr "$TARGET_DIR"/$PATTERN 2>/dev/null))
    local FILE_COUNT=${#FILES[@]}

    # 2. ローテーション実行（必要な場合のみ）
    if [ "$FILE_COUNT" -gt "$KEEP_COUNT" ]; then
        echo "♻️ 古いバックアップをローテーション中..."
        local remove_count=$((FILE_COUNT - KEEP_COUNT))
        
        for (( i=0; i < remove_count; i++ )); do
            rm -f "${FILES[$i]}"
            echo "🗑 削除済み: $(basename "${FILES[$i]}")"
        done
        echo "✅ 最新の $KEEP_COUNT 世代を保持しました。"
    fi

    echo "📂 現在のバックアップ一覧:"
    # ls -1tr を再実行して、残ったファイル名(basename)だけを表示
    ls -1tr "$TARGET_DIR"/$PATTERN 2>/dev/null | xargs -I {} basename {} | sed 's/^/  - /'
    
    IFS="$OLD_IFS"
}

# 実行
backup
rotate