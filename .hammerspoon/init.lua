-- ==========================================
-- ハンマースプーンの自動リロード設定
-- ==========================================
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

-- ~/.hammerspoon 内のファイルを監視して、変更があれば reloadConfig を実行
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

-- ==========================================
-- Pluginの読み込み
-- ==========================================
require("modules.config")
require("modules.git")
require("modules.app_toggle")

-- Configが正常に読み込まれたらアラートを表示する
hs.alert.show("Config Loaded 🚀")
