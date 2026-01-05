--[[
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

  -- リロードは手動で行う
  ]]

-- ==========================================
-- Pluginの読み込み
-- ==========================================
require("modules.config")
require("modules.app_toggle")

local menu = hs.menubar.new()
hs.timer.doEvery(3, function() -- 3秒に1回で十分
    local cpu = hs.host.cpuUsage()
    -- 計算処理...
    menu:setTitle(string.format("CPU: %.1f%%", totalUsage))
end)

-- 動作エラーがなければコードをコミットする
require("modules.git")

-- Configが正常に読み込まれたらアラートを表示する
hs.alert.show("Config Loaded 🚀")
