
hs.timer.doEvery(10, function()
        -- hs.alert.show("test")
    -- システムの標準的な場所から git を探す
    local git = hs.execute("export PATH=$PATH:/usr/local/bin:/opt/homebrew/bin; which git"):gsub("\n", "")
    local repo = os.getenv("HOME") .. "/dotfiles"

    if git == "" then
        hs.alert.show("Git Error: git command not found.")
        return
    end

    -- 実行（認証エラーを防ぐため PATH を引き継ぐ）
    local cmd = string.format("export PATH=$PATH:/usr/local/bin:/opt/homebrew/bin; cd %s && %s add . && %s commit -m 'auto' && %s push", repo, git, git, git)

    local output, status = hs.execute(cmd)

    if not status then
        hs.alert.show("Git Push Error:", output)
    end
end):start()
