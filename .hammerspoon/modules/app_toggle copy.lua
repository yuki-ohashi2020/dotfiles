local function toggleApp(appName, frame)
  local app = hs.application.get(appName)

  -- 起動していなければ起動
  if not app then
    hs.application.launchOrFocus(appName)
    hs.timer.doAfter(0.5, function()
      local a = hs.application.get(appName)
      if a then
        local win = a:mainWindow()
        if win and frame then
          win:setFrame(frame)
        end
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
  local win = app:mainWindow()
  if win and frame then
    win:setFrame(frame)
  end
end



APP_BINDINGS = {
  o = {
    name = "Obsidian",
    frame = { x = 100, y = 100, w = 1200, h = 10 }
  },
  v = {
    name = "Vivaldi",
    frame = { x = 50, y = 50, w = 1400, h = 900 }
  },
}
MOD_APP = {"ctrl", "alt"}
for key, app in pairs(APP_BINDINGS) do
  hs.hotkey.bind(MOD_APP, key, function()
    toggleApp(app.name, app.frame)
  end)
end