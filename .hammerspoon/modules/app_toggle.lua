local function toggleApp(app)
  -- app = { name=..., bundleID=..., frame=... }

  local application =
    app.bundleID and hs.application.get(app.bundleID)
    or hs.application.find(app.name)

  local function applyFrame(win)
    if not win then return end

    if app.frame then
      win:setFrame(app.frame)
    else
      win:setFrame(win:screen():frame())
    end
  end

  -- 起動していなければ起動
  if not application then
    if app.bundleID then
      hs.application.launchOrFocusByBundleID(app.bundleID)
    else
      hs.application.launchOrFocus(app.name)
    end

    hs.timer.doAfter(0.6, function()
      local a =
        app.bundleID and hs.application.get(app.bundleID)
        or hs.application.find(app.name)

      if not a then return end
      a:activate(true)

      hs.timer.doAfter(0.2, function()
        applyFrame(a:focusedWindow() or a:mainWindow())
      end)
    end)
    return
  end

  -- 表示中なら非表示
  if application:isFrontmost() then
    application:hide()
    return
  end

  -- 非表示なら表示
  application:activate(true)

  hs.timer.doAfter(0.1, function()
    applyFrame(application:focusedWindow() or application:mainWindow())
  end)
end


for key, app in pairs(APP_BINDINGS) do
  hs.hotkey.bind(MOD_APP_KEY, key, function()
    toggleApp(app.name, app.frame)
  end)
end
