-- ==========================================
-- スリープウォッチ
-- ==========================================
SLEEPED = 10
WAKED = 11
WAIT_SEC = 3
VOLUME_PER = 20

sleepWatcher = hs.caffeinate.watcher.new(function(eventType)
    print("Caffeinate event:", eventType)

    -- ディスプレイがスリープ (イベント 10)
    if (eventType == SLEEPED) then
        -- TODO: BTTのスリープの設定をここに持ってくること
    end
    
    -- ディスプレイがスリープから復帰 (イベント 11)
    if (eventType == WAKED) then
        hs.timer.doAfter(WAIT_SEC, function()
            print("✅Caffeinate event: WAKED")

            hs.alert.show("🎉 おかえりなさい、ボス！", 3)
            hs.audiodevice.defaultOutputDevice():setVolume(VOLUME_PER)
            
            -- Wi-Fiが安定するまで待ってからアプリを起動する例
            -- hs.timer.doAfter(2, function()
            --     hs.application.launchOrFocus("Slack")
            -- end)
        end)
    end
    
    -- システム全体のスリープから復帰 (イベント 0)
    --[[
    if (eventType == 0) then
        hs.timer.doAfter(1, function()
            hs.alert.show("🎉 おかえりなさい、ボス！（システム復帰）", 3)
            hs.sound.getByName("Ping"):play()
        end)
    end
    ]]
end)

-- ウォッチャーの開始
sleepWatcher:start()
print("✅Sleep Watcher start---")
