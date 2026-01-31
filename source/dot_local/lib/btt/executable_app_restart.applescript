#!/usr/bin/env osascript

-- 最前面にあるアプリを再起動する
tell application "System Events"
    -- 最前面のプロセスを取得
    set frontProcess to first process whose frontmost is true
    set procName to name of frontProcess
    set appPath to (POSIX path of (application file of frontProcess))
    set pid to unix id of frontProcess
end tell

-- Finder（デスクトップ）の場合はここで終了
if procName is "Finder" then
    return
end if

-- プロセスID(PID)を使って強制終了（ダイアログを出させない）
do shell script "kill " & pid

-- 完全に終了するまで少し待機
delay 0.5

-- 再起動
do shell script "open " & quoted form of appPath
