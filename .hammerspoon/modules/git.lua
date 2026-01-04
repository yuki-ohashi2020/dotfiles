
local gitTimer = hs.timer.doEvery(10, function()
    local repo = os.getenv("HOME") .. "/dotfiles"
    -- 1. PATHを通す
    -- 2. ディレクトリ移動
    -- 3. add, commit, push を順番に実行（途中で止まらないように ";" で繋ぐ）
    local cmd = string.format(
        "export PATH=$PATH:/usr/local/bin:/opt/homebrew/bin; cd %s; git add .; git commit -m 'auto' 2>/dev/null; git push 2>&1",
        repo
    )

    local output, status = hs.execute(cmd)

    -- pushの結果に "Everything up-to-date" または "master -> master" が含まれていれば成功とみなす
    if status then
        print("Git Sync Success")
    elseif output and output:find("ahead of") or output:find("up-to-date") then
        -- statusがfalseでも、このメッセージがあれば実質成功、またはpushが必要な状態
        -- 強制的にpushを試みる
        hs.execute("export PATH=$PATH:/usr/local/bin:/opt/homebrew/bin; cd " .. repo .. " && git push")
    end
end):start()
