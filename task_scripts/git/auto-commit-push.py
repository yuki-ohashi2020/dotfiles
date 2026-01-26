import os
import subprocess
import sys
import argparse
from datetime import datetime


def run_git_sync():
    # 1. 引数の解析設定
    parser = argparse.ArgumentParser(
        description="指定したディレクトリをGitで自動同期します。"
    )
    # --dir オプションを追加。省略された場合はカレントディレクトリを対象にする設定
    parser.add_argument(
        "--dir", type=str, help="同期するドットファイルのディレクトリパス", default="."
    )

    args = parser.parse_args()
    target_dir = args.dir

    # 2. パスの存在確認
    if not os.path.isdir(target_dir):
        print(f"❌ Error: ディレクトリが見つかりません: {target_dir}")
        sys.exit(1)

    # 作業ディレクトリの移動
    os.chdir(target_dir)
    print(f"📂 Target directory: {os.getcwd()}")

    try:
        # git status --porcelain の実行
        status_proc = subprocess.run(
            ["git", "status", "--porcelain"], capture_output=True, text=True, check=True
        )

        # 変更があるか確認
        if status_proc.stdout.strip():
            print("🚀 Changes detected. Pushing to GitHub...")

            now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

            # git 操作
            subprocess.run(["git", "add", "--all"], check=True)
            subprocess.run(["git", "commit", "-m", f"auto commit: {now}"], check=True)
            subprocess.run(["git", "push", "origin", "main"], check=True)

            print("✅ Successfully pushed changes.")
        else:
            print("✨ No changes.")

    except subprocess.CalledProcessError as e:
        print(f"❌ Git operation failed: {e}")
        sys.exit(1)


if __name__ == "__main__":
    run_git_sync()
