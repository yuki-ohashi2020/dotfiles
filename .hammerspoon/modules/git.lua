-- ==========================================
-- auto commit & Push
-- ==========================================
local function autoGitSync()
    local repo = os.getenv("HOME") .. "/dotfiles"
    local timestamp = os.date("%Y/%m/%d %H:%M")
    local commitMsg = string.format("auto commit: %s", timestamp)

    local cmd = string.format([[
        cd %s && git add . && git commit -m '%s' && git push
    ]], repo, commitMsg)

    local output, status = hs.execute(cmd)

    if not status and not string.match(output or "", "nothing to commit") then
        print("Git error:", output)
    end
end

-- 1. 初回起動時に実行（差分があれば即コミット）
autoGitSync()

-- 2. 以降、3分間隔で実行
local gitTimer = hs.timer.doEvery(GIT_NTERVAL, autoGitSync):start()
