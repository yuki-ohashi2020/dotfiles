
local gitTimer = hs.timer.doEvery(1, function()
    local repo = os.getenv("HOME") .. "/dotfiles"
    -- 末尾に "2>&1" を追加して、エラー出力を標準出力に統合する
    local cmd = "export PATH=$PATH:/usr/local/bin:/opt/homebrew/bin; cd " .. repo .. " && git add . && git commit -m 'auto' && git push 2>&1"

    local output, status = hs.execute(cmd)

    if not status then
        -- これで空だった output にエラーメッセージが入ります
        hs.alert.show("Git Error: " .. (output or "unknown"), 5)
    end
end):start()
