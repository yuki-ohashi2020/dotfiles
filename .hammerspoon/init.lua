local reloadTimer = nil

function reloadConfig(files)
  local shouldReload = false

  for _, file in pairs(files) do
    if file:match("%.lua$") then
      shouldReload = true
      break
    end
  end

  if shouldReload then
    if reloadTimer then
      reloadTimer:stop()
    end

    reloadTimer = hs.timer.doAfter(0.5, function()
      hs.reload()
    end)
  end
end

hs.pathwatcher
  .new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig)
  :start()

hs.loadSpoon("HSKeybindings")

-- HSKeybindings は bindHotkeys ではなく hotkeyBind を使います
-- 第一引数が「修飾キー」、第二引数が「キー」です。
-- 例：F1キーだけで表示する場合
hs.hotkey.bind(MOD_APP_KEY, "y", function() spoon.HSKeybindings:show() end)

-- ==========================================
-- Pluginの読み込み
-- ==========================================
require("modules.config")
require("modules.git")
require("modules.app_toggle")

-- Configが正常に読み込まれたらアラートを表示する
hs.alert.show("Config Loaded 🚀")
