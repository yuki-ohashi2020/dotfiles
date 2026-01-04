-- 3分に一度、git commitとpushをする
local gitTimer = hs.timer.doEvery(3 * 60, function()
    local repo = os.getenv("HOME") .. "/dotfiles"
    local timestamp = os.date("%Y/%m/%d %H:%M:%S")
    local commitMsg = string.format("auto commit: %s", timestamp)

    local cmd = string.format([[
        cd %s && git add . && git commit -m '%s' && git push
    ]], repo, commitMsg)

    local output, status = hs.execute(cmd)

    if not status and not string.match(output or "", "nothing to commit") then
        print("Git error:", output)
    end
end):start()
