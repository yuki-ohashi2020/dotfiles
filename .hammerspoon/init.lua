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

-- スリープ状態を監視するウォッチャーの作成
sleepWatcher = hs.caffeinate.watcher.new(function(eventType)
    -- ディスプレイがスリープ (イベント 10)
    if (eventType == 10) then
        -- 必要に応じてスリープ時の処理
    end
    
    -- ディスプレイがスリープから復帰 (イベント 11)
    if (eventType == 11) then
        hs.timer.doAfter(1, function()
            hs.alert.show("🎉 おかえりなさい、ボス！", 3)
            hs.sound.getByName("Ping"):play()
            
            -- Wi-Fiが安定するまで待ってからアプリを起動する例
            -- hs.timer.doAfter(2, function()
            --     hs.application.launchOrFocus("Slack")
            -- end)
        end)
    end
    
    -- システム全体のスリープから復帰 (イベント 0)
    if (eventType == 0) then
        hs.timer.doAfter(1, function()
            hs.alert.show("🎉 おかえりなさい、ボス！（システム復帰）", 3)
            hs.sound.getByName("Ping"):play()
        end)
    end
end)

-- ウォッチャーの開始
sleepWatcher:start()

-- 動作エラーがなければコードをコミットする
require("modules.git")

-- Configが正常に読み込まれたらアラートを表示する
hs.alert.show("Config Loaded 🚀")
