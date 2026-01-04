local gitTimer = hs.timer.doEvery(5, function()
    local repo = os.getenv("HOME") .. "/dotfiles"
    -- ボスの SSH 鍵のパスを確認してください（例: ~/.ssh/id_ed25519 や ~/.ssh/id_rsa）
    local sshKey = os.getenv("HOME") .. "/.ssh/id_ed25519"

    -- コマンドの組み立て
    -- 1. PATHを通す
    -- 2. GIT_SSH_COMMAND で鍵を指定して push する
    local cmd = string.format(
        "export PATH=$PATH:/usr/local/bin:/opt/homebrew/bin; cd %s; git add .; git commit -m 'auto' 2>/dev/null; GIT_SSH_COMMAND='ssh -i %s -o StrictHostKeyChecking=no' git push 2>&1",
        repo,
        sshKey
    )

    local output, status = hs.execute(cmd)

    -- デバッグ用：失敗した時だけコンソールに内容を出す
    if not status then
        print("Git Push Attempt Output: ", output)
    end
end):start()
