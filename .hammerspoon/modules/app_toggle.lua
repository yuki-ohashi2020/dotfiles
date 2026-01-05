local function toggleApp(appName, frame)
  local app = hs.application.get(appName)

  local function applyFrame(win)
    if not win then return end

    if frame then
      win:setFrame(frame)
    else
      -- frame 未指定なら、そのウィンドウがある画面いっぱい
      win:setFrame(win:screen():frame())
    end
  end

  -- 起動していなければ起動
  if not app then
    hs.application.launchOrFocus(appName)
    hs.timer.doAfter(0.5, function()
      local a = hs.application.get(appName)
      if a then
        applyFrame(a:mainWindow())
      end
    end)
    return
  end

  -- 表示中なら非表示
  if app:isFrontmost() then
    app:hide()
    return
  end

  -- 非表示なら表示
  app:activate(true)
  applyFrame(app:mainWindow())
end

for key, app in pairs(APP_BINDINGS) do
  hs.hotkey.bind(MOD_APP_KEY, key, function()
    toggleApp(app.name, app.frame)
  end)
end
