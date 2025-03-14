-- 緑色の横棒を画面最下部の右半分にぴったり表示するHammerspoonスクリプト

-- 画面の横棒を表示するキャンバスを作成
local screenEdgeCanvas = nil

-- 画面のメインディスプレイの情報を取得
local mainScreen = hs.screen.mainScreen()
local screenFrame = mainScreen:frame()
local absoluteFrame = mainScreen:fullFrame()  -- 絶対座標を取得

-- 表示する横棒の設定
local barConfig = {
    width = screenFrame.w * 0.5,    -- 画面幅の50%（右半分）
    height = screenFrame.h * 0.05,  -- 画面高さの5%
    color = {red=0, green=1, blue=0, alpha=1},  -- 緑色
    xPosition = screenFrame.w * 0.5  -- 右半分の開始位置
}

-- 横棒を表示する関数
function showEdgeBar()
    -- すでにキャンバスが存在する場合は削除
    if screenEdgeCanvas then
        screenEdgeCanvas:delete()
    end
    
    -- 新しいキャンバスを作成（絶対座標系を使用）
    screenEdgeCanvas = hs.canvas.new({
        x = barConfig.xPosition,
        y = absoluteFrame.h - barConfig.height,  -- 絶対座標での最下部
        w = barConfig.width,
        h = barConfig.height
    })
    
    -- キャンバスの設定
    screenEdgeCanvas:appendElements({
        type = "rectangle",
        action = "fill",
        fillColor = {red=0, green=1, blue=0, alpha=1},
        roundedRectRadii = {xRadius = 0, yRadius = 0}
    })
    
    -- 常に他のウィンドウの上に表示し、最前面に保持
    screenEdgeCanvas:level(hs.canvas.windowLevels.overlay)
    screenEdgeCanvas:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces + 
                             hs.canvas.windowBehaviors.stationary)
    
    -- キャンバスを表示
    screenEdgeCanvas:show()
end

-- 画面サイズが変わった時に横棒の位置やサイズを更新
screenWatcher = hs.screen.watcher.new(function()
    mainScreen = hs.screen.mainScreen()
    screenFrame = mainScreen:frame()
    absoluteFrame = mainScreen:fullFrame()
    barConfig.width = screenFrame.w * 0.5
    barConfig.height = screenFrame.h * 0.05
    barConfig.xPosition = screenFrame.w * 0.5
    showEdgeBar()
end)

-- 初期表示とスクリーンウォッチャーの開始
showEdgeBar()
screenWatcher:start()



