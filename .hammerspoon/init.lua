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
require("modules.git")
-- AppLauncherをロード
hs.loadSpoon("AppLauncher")
spoon.AppLauncher.modifiers = {"ctrl", "alt"}

-- キーとアプリの紐付け（左がキー、右がアプリケーション名）
spoon.AppLauncher:bindHotkeys({
  s = "Slack",
  o = "Obsidian",
  c = "Google Chrome",
  f = "Finder",
  t = "Terminal"
})


-- Configが正常に読み込まれたらアラートを表示する
hs.alert.show("Config Loaded 🚀")
