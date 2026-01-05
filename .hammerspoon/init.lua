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
    
    -- システムのスリープから復帰
    if (eventType == hs.caffeinate.watcher.systemDidWake) then
        print("System woke up!")
        hs.alert.show("おかえりなさい、ボス！（システム復帰）", 3)
        hs.notify.new({title="Hammerspoon", informativeText="システムが復帰しました"}):send()
    end
    
    -- ディスプレイのスリープから復帰
    if (eventType == hs.caffeinate.watcher.screensDidWake) then
        print("Screens woke up!")
        hs.alert.show("おかえりなさい、ボス！", 3)
        hs.notify.new({title="Hammerspoon", informativeText="ディスプレイが復帰しました"}):send()
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
