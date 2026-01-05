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
    -- すべてのイベントをログに記録（デバッグ用）
    print("Caffeinate event:", eventType)
    
    if (eventType == hs.caffeinate.watcher.systemDidWake) then
        -- スリープから復帰した時の処理
        print("System woke up!")  -- コンソールログ
        hs.alert.show("おかえりなさい、ボス！", 3)  -- 3秒間表示
        
        -- 通知センターにも表示（より確実）
        hs.notify.new({title="Hammerspoon", informativeText="おかえりなさい、ボス！"}):send()
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
