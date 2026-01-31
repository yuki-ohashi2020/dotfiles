import subprocess
import argparse


def main():
    STATUS_DA = "DA"  # ターゲットで削除済み、ソースには残っている
    MIN_COLUMNS = 2
    STATUS_COLUMN = 0
    FILE_PATH_COLUMN = 1

    # コマンドライン引数の解析
    parser = argparse.ArgumentParser(description="chezmoi DA状態のファイルをforget")
    parser.add_argument(
        "--target-dir", required=True, help="ターゲットディレクトリのパス（例: $HOME）"
    )
    args = parser.parse_args()

    target_dir = args.target_dir

    # 削除されたファイルを取得
    result = subprocess.run(["chezmoi", "status"], capture_output=True, text=True)

    # DA状態のファイル（ターゲットで削除済み、ソースには残っている）
    da_files = []

    for line in result.stdout.splitlines():
        parts = line.split(maxsplit=1)
        if len(parts) < MIN_COLUMNS:
            continue

        status = parts[STATUS_COLUMN]
        filepath = parts[FILE_PATH_COLUMN]

        if status == STATUS_DA:
            da_files.append(filepath)

    if not da_files:
        print("DA状態のファイルはありません")
        return

    # 確認
    print("以下のファイルを処理します:")
    print("[DA] ターゲットで削除済み、ソースには残っている (chezmoi forget):")
    for file in da_files:
        print(f"  {file}")
    print(f"\n合計: {len(da_files)} ファイル")

    response = input("\n処理しますか？ (y/n): ").strip().lower()
    if response != "y":
        print("キャンセルしました")
        return

    # 実行（target_dirを付けたフルパスで指定、--forceオプション付き）
    for file in da_files:
        full_path = f"{target_dir}/{file}"
        subprocess.run(["chezmoi", "forget", "--force", full_path])

    print("\n完了しました")


if __name__ == "__main__":
    main()
