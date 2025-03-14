-- ~/.hammerspoon/init.lua

-- モジュールのパスを相対パスで設定
local home = os.getenv("HOME")
package.path = package.path .. ";" .. home .. "/.hammerspoon/modules/?.lua"

-- または以下のようにもっとシンプルに
-- package.path = package.path .. ";./modules/?.lua"

-- 各モジュールを読み込む
require("vim_mode")
-- その他のモジュールを追加
