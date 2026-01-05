-- AppLauncherをロード
hs.loadSpoon("AppLauncher")
spoon.AppLauncher.modifiers = {"ctrl", "alt"}

-- キーとアプリの紐付け（左がキー、右がアプリケーション名）
spoon.AppLauncher:bindHotkeys({
  s = "Slack",
  o = "Obsidian",
  c = "Google Chrome",
  f = "Finder",
  t = "Terminal"
})