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

local volumeMenuBar = hs.menubar.new()

local function updateVolume()
    -- currentOutputDevice() ではなく defaultOutputDevice() を使用
    local device = hs.audiodevice.defaultOutputDevice()
    
    if device then
        local vol = device:volume()
        local muted = device:muted()
        
        if muted then
            volumeMenuBar:setTitle("🔇 Muted")
        else
            volumeMenuBar:setTitle(string.format("🔊 %.0f%%", vol))
        end
    else
        volumeMenuBar:setTitle("🚫 No Device")
    end
end

-- クリックでミュート切り替え
volumeMenuBar:setClickCallback(function()
    local device = hs.audiodevice.defaultOutputDevice()
    if device then
        device:setMuted(not device:muted())
        updateVolume()
    end
end)

-- 2秒ごとに更新
hs.timer.doEvery(2, updateVolume)

-- 初回実行
updateVolume()

-- 動作エラーがなければコードをコミットする
require("modules.git")

-- Configが正常に読み込まれたらアラートを表示する
hs.alert.show("Config Loaded 🚀")
