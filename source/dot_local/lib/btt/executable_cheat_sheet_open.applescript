#!/usr/bin/env osascript

set targetPath to do shell script "echo $CHEZMOI_PATH/cheat_sheet_global.numbers"

do shell script "open -a Numbers " & quoted form of targetPath
