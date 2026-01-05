hs.hotkey.bind({"ctrl","alt"}, "o", function()
  toggleApp("Obsidian", {
    x = 100, y = 100, w = 1200, h = 800
  })
end)

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
