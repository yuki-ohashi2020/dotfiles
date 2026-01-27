import subprocess
import sys

# 色定義
TEXT_COLOR = "231"  # 白
BG_COLOR = "24"  # 青


def header(text: str) -> None:
    """スタイル付きヘッダーを表示する"""
    border = "━" * 50

    print(border)
    subprocess.run(
        [
            "gum",
            "style",
            "--foreground",
            TEXT_COLOR,
            "--background",
            BG_COLOR,
            "--bold",
            "--padding",
            "2 4",
            "--width",
            "50",
            "--align",
            "left",
            text,
        ]
    )
    print(border)


if __name__ == "__main__":
    text = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else "Header Text"
    header(text)
