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
    print("Caffeinate event:", eventType)
    print("screensDidWake value:", hs.caffeinate.watcher.screensDidWake)
    print("systemDidWake value:", hs.caffeinate.watcher.systemDidWake)
    print("Match?", eventType == hs.caffeinate.watcher.screensDidWake)
    
    -- 数値で直接比較
    if (eventType == 11) then
        print("Event 11 detected!")
        hs.timer.doAfter(1, function()
            hs.alert.show("🎉 おかえりなさい、ボス！", 5)
            hs.sound.getByName("Ping"):play()
            print("Alert should be visible now")
        end)
    end
    
    if (eventType == 10) then
        print("Event 10 detected! (screen sleep)")
    end
end)

-- ウォッチャーの開始
sleepWatcher:start()

-- 起動時の確認メッセージ
hs.alert.show("スリープウォッチャーが起動しました")
print("Sleep watcher started")

-- 動作エラーがなければコードをコミットする
require("modules.git")

-- Configが正常に読み込まれたらアラートを表示する
hs.alert.show("Config Loaded 🚀")
