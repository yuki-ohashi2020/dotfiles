--- テキストキャレットに薄い青のオーバーレイを表示するスクリプト (エラー修正版)
--- Light blue overlay for text caret in Hammerspoon

-- コンソールログを表示する（デバッグ用）
hs.console.clearConsole()
print("キャレットオーバーレイスクリプト（エラー修正版）を読み込みました")

-- オーバーレイのウィンドウを保持する変数
local caretOverlay = nil

-- キャレットの前の位置
local lastCaretPos = {}

-- キャレット追跡用のタイマー
local caretTimer = nil

-- オーバーレイの設定
local config = {
    color = {63, 151, 255, 80},  -- 薄い青色 (RGBA形式、アルファ値80)
    width = 2,                   -- オーバーレイの幅（ピクセル）
    height = 20,                 -- オーバーレイの高さ（ピクセル）
    updateInterval = 0.1,        -- 更新間隔（秒）
    xOffset = 0,                 -- X座標オフセット（調整可能）
    yOffset = 0                  -- Y座標オフセット（調整可能）
}

-- オーバーレイウィンドウを作成
function createOverlay()
    if caretOverlay then
        caretOverlay:delete()
    end

    print("オーバーレイウィンドウを作成します")
    caretOverlay = hs.drawing.rectangle(hs.geometry.rect(0, 0, config.width, config.height))
    caretOverlay:setFillColor({hex = "#3F97FF", alpha = 0.5}) -- 薄い青色（アルファ値0.5）
    caretOverlay:setLevel(hs.drawing.windowLevels.overlay + 10) -- レベルを少し上げる
    caretOverlay:setStroke(false)
    caretOverlay:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
    caretOverlay:show()
    print("オーバーレイウィンドウを作成しました")
end

-- アプリケーション情報を取得
function getAppInfo()
    -- hs.applicationモジュールが読み込まれていることを確認
    if not hs.application then
        print("hs.applicationモジュールが読み込まれていません")
        return nil
    end

    -- 現在のアプリケーションを取得
    local app = nil

    -- frontmostメソッドが存在するか確認
    if hs.application.frontmost then
        app = hs.application.frontmost()
    else
        -- 別の方法でアプリケーションを取得
        print("frontmostメソッドがありません。別の方法を試します")
        local apps = hs.application.runningApplications()
        for _, a in ipairs(apps) do
            if a:isFrontmost() then
                app = a
                break
            end
        end
    end

    if not app then
        print("フロントアプリケーションを特定できません")
        return nil
    end

    local appName = app:name()
    local bundleID = app:bundleID()

    print("現在のアプリ:", appName, "（BundleID:", bundleID, "）")
    return {
        name = appName,
        bundleID = bundleID
    }
end

-- アプリケーション別の調整値を取得
function getAppSpecificAdjustment(appInfo)
    if not appInfo then return {x=0, y=0} end

    -- アプリケーション別の調整値
    local adjustments = {
        -- TextEdit
        ["com.apple.TextEdit"] = {x=0, y=0},

        -- メモ
        ["com.apple.Notes"] = {x=0, y=0},

        -- VS Code
        ["com.microsoft.VSCode"] = {x=0, y=0},

        -- その他のアプリを必要に応じて追加
    }

    local adjustment = adjustments[appInfo.bundleID]
    if adjustment then
        return adjustment
    else
        return {x=0, y=0} -- デフォルト値
    end
end

-- キャレットの位置を取得
function getCaretPosition()
    local element = hs.axuielement.systemWideElement():attributeValue("AXFocusedUIElement")
    if not element then
        print("フォーカスされたUI要素が見つかりません")
        return nil
    end

    local role = element:attributeValue("AXRole") or "不明"
    print("フォーカス要素:", role)

    -- テキスト入力要素でない場合は親要素も確認
    if role ~= "AXTextField" and role ~= "AXTextArea" then
        local parent = element:attributeValue("AXParent")
        if parent then
            element = parent
            role = element:attributeValue("AXRole") or "不明"
            print("親要素を確認:", role)
        end
    end

    -- テキスト選択範囲を取得
    local caret = element:attributeValue("AXSelectedTextRange")
    if not caret then
        print("テキスト選択範囲が見つかりません")
        -- 別の方法を試す：キャレット位置属性
        local caretPos = element:attributeValue("AXSelectedTextMarkerRange")
        if not caretPos then
            print("キャレット位置も見つかりません")
            return nil
        end
        caret = caretPos
    end

    -- キャレットの位置を画面座標に変換
    local caretBounds = element:parameterizedAttributeValue("AXBoundsForRange", caret)
    if not caretBounds then
        print("キャレットの境界が取得できません")
        return nil
    end

    -- nilチェック
    local x = caretBounds.x or 0
    local y = caretBounds.y or 0
    local width = caretBounds.width or 0
    local height = caretBounds.height or 0

    print("キャレット生の位置:", x, y, width, height)

    -- アプリケーション固有の調整を適用（エラー回避のため安全に呼び出す）
    local adjustment = {x=0, y=0}

    -- 安全にアプリ情報を取得
    local success, appInfo = pcall(getAppInfo)
    if success and appInfo then
        adjustment = getAppSpecificAdjustment(appInfo)
    else
        print("アプリ情報の取得中にエラーが発生しました")
    end

    -- 調整を適用
    x = x + adjustment.x + config.xOffset
    y = y + adjustment.y + config.yOffset

    print("調整後のキャレット位置:", x, y, width, height)

    return {
        x = x,
        y = y,
        width = width > 0 and width or config.width,
        height = height > 0 and height or config.height
    }
end

-- キャレットオーバーレイを更新
function updateCaretOverlay()
    local pos = getCaretPosition()

    if not pos then
        if caretOverlay and caretOverlay:isShowing() then
            print("キャレットが見つからないためオーバーレイを非表示にします")
            caretOverlay:hide()
        end
        return
    end

    -- キャレットの位置が変わった場合のみ更新
    if not lastCaretPos or
       lastCaretPos.x ~= pos.x or
       lastCaretPos.y ~= pos.y then

        print("キャレット位置が変更されました - 更新します")

        -- オーバーレイがまだ作成されていない場合は作成
        if not caretOverlay then
            createOverlay()
        end

        -- オーバーレイの位置とサイズを更新
        caretOverlay:setFrame(hs.geometry.rect(
            pos.x,
            pos.y,
            pos.width > 0 and pos.width or config.width,
            pos.height > 0 and pos.height or config.height
        ))

        caretOverlay:show()
        lastCaretPos = pos
    end
end

-- キャレットオーバーレイを開始
function startCaretOverlay()
    if caretTimer then
        caretTimer:stop()
    end

    print("キャレットオーバーレイを開始します")
    createOverlay()
    caretTimer = hs.timer.new(config.updateInterval, updateCaretOverlay)
    caretTimer:start()
    hs.alert.show("キャレットオーバーレイをオンにしました", 2)
end

-- キャレットオーバーレイを停止
function stopCaretOverlay()
    print("キャレットオーバーレイを停止します")
    if caretTimer then
        caretTimer:stop()
        caretTimer = nil
    end

    if caretOverlay then
        caretOverlay:delete()
        caretOverlay = nil
    end

    lastCaretPos = {}
    hs.alert.show("キャレットオーバーレイをオフにしました", 2)
end

-- オフセット値を調整するための関数
function adjustOffsets(dx, dy)
    config.xOffset = config.xOffset + dx
    config.yOffset = config.yOffset + dy
    print("新しいオフセット値:", config.xOffset, config.yOffset)

    hs.alert.show(string.format("オフセット: X=%d, Y=%d", config.xOffset, config.yOffset), 1)

    -- 位置を即座に更新
    updateCaretOverlay()
end

-- テストオーバーレイを表示
function testOverlay()
    local screenFrame = hs.screen.mainScreen():frame()
    local testOverlay = hs.drawing.rectangle(hs.geometry.rect(
        screenFrame.w / 2 - 50,
        screenFrame.h / 2 - 50,
        100,
        100
    ))
    testOverlay:setFillColor({hex = "#FF0000", alpha = 0.5}) -- 赤色
    testOverlay:setLevel(hs.drawing.windowLevels.overlay)
    testOverlay:setStroke(false)
    testOverlay:show()

    hs.alert.show("テストオーバーレイを表示しました。3秒後に消えます。")
    hs.timer.doAfter(3, function() testOverlay:delete() end)
end

-- スクリプトの初期化
print("スクリプトを初期化します")
hs.alert.show("キャレットオーバーレイスクリプトを初期化しています", 2)

-- 必要なモジュールを読み込み
print("必要なモジュールを確認中...")
if not hs.application then
    print("hs.applicationモジュールを読み込みます")
    require("hs.application")
end

-- テストオーバーレイを表示（デバッグ用）
testOverlay()

-- 少し遅らせてからキャレットオーバーレイを開始
hs.timer.doAfter(1, function()
    startCaretOverlay()
end)

-- ホットキー設定
-- オーバーレイのオン/オフを切り替え
hs.hotkey.bind({"cmd", "alt"}, "C", function()
    if caretTimer and caretTimer:running() then
        stopCaretOverlay()
    else
        startCaretOverlay()
    end
end)

-- テストモードをオン/オフするホットキー
hs.hotkey.bind({"cmd", "alt"}, "T", function()
    testOverlay()
    hs.alert.show("テストオーバーレイを表示しました")
end)

-- 位置調整用のホットキー
-- カーソルオーバーレイを左に移動
hs.hotkey.bind({"cmd", "alt", "shift"}, "left", function()
    adjustOffsets(-1, 0)
end)

-- カーソルオーバーレイを右に移動
hs.hotkey.bind({"cmd", "alt", "shift"}, "right", function()
    adjustOffsets(1, 0)
end)

-- カーソルオーバーレイを上に移動
hs.hotkey.bind({"cmd", "alt", "shift"}, "up", function()
    adjustOffsets(0, -1)
end)

-- カーソルオーバーレイを下に移動
hs.hotkey.bind({"cmd", "alt", "shift"}, "down", function()
    adjustOffsets(0, 1)
end)

print("スクリプトの設定が完了しました")
