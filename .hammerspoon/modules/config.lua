MOD_APP_KEY = {"ctrl", "alt", "shift"}

APP_BINDINGS = {
  space = { name = "Alfred" },

  a = { name = "Activity Monitor" },

  [","] = {
  action = function()
    hs.urlevent.openURLWithBundle(
      "bettertouchtool://openPreferences",
      "com.hegenberg.BetterTouchTool"
    )
  end
},
  t = {
    name = "iTerm",
    bundleID = "com.googlecode.iterm2"
  },

  b = { name = "Vivaldi" },
  f = { name = "Finder" },
  g = { name = "GitHub" },
  o = { name = "Obsidian" },
  v = {
    name = "Visual Studio Code",
    bundleID = "com.microsoft.VSCode"
  },
}


-- ==========================================
-- Git
-- ==========================================
GIT_NTERVAL = 3 * 60