local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ========================================
-- 外観
-- ========================================
-- フォント
config.font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Medium" })
config.font_size = 16.0

-- 行間
config.line_height = 1.2

-- カラースキーム(テーマ)
config.color_scheme = 'Dracula (Official)'

-- 背景透過(0: 全透過 ~ 1:非透過)
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20 -- macOSなら背景をぼかすと視認性UP


-- タブが1つの時は隠す
-- config.hide_tab_bar_if_only_one_tab = true

config.window_decorations = "RESIZE" -- タイトルバーを非表示
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

config.use_fancy_tab_bar = false -- シンプルなタブバー
config.tab_bar_at_bottom = true  -- タブを下部に


-- ========================================
-- 動作設定
-- ========================================
-- スクロールバック
config.scrollback_lines = 10000
config.default_prog = { 'zsh', '--login' } -- デフォルトシェルを指定（環境に合わせて変更）
config.enable_scroll_bar = true

config.use_ime = true
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"

-- カーソル
-- config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 500

-- アニメーション無効化（高速化）
config.animation_fps = 1

-- ビープ音を消す
config.audible_bell = "Disabled"

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.animation_fps = 60
config.max_fps = 60

-- ========================================
-- その他の便利設定
-- ========================================
-- 起動時のシェル（必要に応じて変更）
config.default_prog = { "/bin/zsh", "-l" }

-- リンクのクリック設定
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- 自動更新チェック
config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400

return config
