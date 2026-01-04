local gitTimer = hs.timer.doEvery(5, function()
    local repo = os.getenv("HOME") .. "/dotfiles"

    local cmd = string.format([[
        cd %s && git add . && git commit -m 'auto' && git push
    ]], repo)

    local output, status = hs.execute(cmd)

    if not status then
        print("Git error:", output)
    end
end):start()
