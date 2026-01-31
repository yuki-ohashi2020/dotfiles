import subprocess
import sys


def get_deleted_files():
    """chezmoi statusから削除されたファイルのリストを取得"""
    try:
        result = subprocess.run(
            ["chezmoi", "status"], capture_output=True, text=True, check=True
        )

        deleted_files = []
        for line in result.stdout.splitlines():
            if line.startswith("D"):
                # 2列目を取得（スペースで分割）
                parts = line.split(maxsplit=1)
                if len(parts) >= 2:
                    deleted_files.append(parts[1])

        return deleted_files

    except subprocess.CalledProcessError as e:
        print(f"エラー: chezmoi statusの実行に失敗しました: {e}", file=sys.stderr)
        sys.exit(1)
    except FileNotFoundError:
        print("エラー: chezmoi", file=sys.stderr)
        sys.exit(1)


def confirm_forget(files):
    """削除対象の確認とユーザー入力"""
    if not files:
        print("削除対象のファイルはありません")
        return False

    print("以下のファイルをforgetします:")
    print("-" * 50)
    for file in files:
        print(f"  {file}")
    print("-" * 50)
    print(f"合計: {len(files)} ファイル")
    print()

    while True:
        response = input("forgetしますか？ (y/n): ").strip().lower()

        return response in ["y"]


def forget_files(files):
    """ファイルをforget"""
    try:
        # chemoiコマンドを実行
        cmd = ["chezmoi", "forget"] + files
        subprocess.run(cmd, check=True)
        print(f"\n✓ {len(files)} ファイルをforgetしました")
        return True

    except subprocess.CalledProcessError as e:
        print(f"エラー: chezmoi forgetの実行に失敗しました: {e}", file=sys.stderr)
        return False


def main():
    print("削除されたファイルを確認中...")
    deleted_files = get_deleted_files()

    if confirm_forget(deleted_files):
        forget_files(deleted_files)
    else:
        print("キャンセルしました")


if __name__ == "__main__":
    main()
