
hs.timer.doEvery(20, function()
    -- シムリンクの実体の親ディレクトリ（dotfiles）を取得して、そこでgitを実行
    local cmd = "target=$(readlink " .. hs.configdir .. " || echo " .. hs.configdir .. ") && cd $(dirname $target) && git add . && git commit -m 'auto' && git push"
    hs.execute(cmd)
end):start()
