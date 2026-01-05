local function toggleApp(app)
  local function findApp()
    return app.bundleID
      and hs.application.get(app.bundleID)
      or hs.application.find(app.name)
  end

  local function launchApp()
    if app.bundleID then
      hs.application.launchOrFocusByBundleID(app.bundleID)
    else
      hs.application.launchOrFocus(app.name)
    end
  end

  local function applyFrame(win)
    if not win then return end
    win:setFrame(app.frame or win:screen():frame())
  end

  local application = findApp()

  -- 起動していない → 起動して表示
  if not application then
    launchApp()

    hs.timer.doAfter(0.6, function()
      local a = findApp()
      if not a then return end

      a:activate(true)
      applyFrame(a:focusedWindow() or a:mainWindow())
    end)
    return
  end

  -- 表示中 → 非表示
  if application:isFrontmost() then
    application:hide()
    return
  end

  -- 非表示 → 表示
  application:activate(true)
  applyFrame(application:focusedWindow() or application:mainWindow())
end

-- バインドするキーの登録
for key, app in pairs(APP_BINDINGS) do
  hs.hotkey.bind(MOD_APP_KEY, key, function()
    app.action()
  end)
end
