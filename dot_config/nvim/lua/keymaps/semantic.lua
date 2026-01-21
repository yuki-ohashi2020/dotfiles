-- 今のところLeaderキーの実装の定義のみ記述している

local keymap = vim.keymap.set
local notify = vim.notify
local WARN = vim.log.levels.WARN

local MODE_NORMAL = "n"

-- 未実装キー用のハンドラを生成する
local function not_implemented(action_name)
  return function()
    notify(action_name .. " : not implemented", WARN)
  end
end

local function keymap_set(semantic)
  for action_name, input_key in pairs(semantic) do
    keymap(
      MODE_NORMAL,
      input_key,
      not_implemented(action_name),
      { desc = action_name }
    )
  end
end

local semantic = {
  -- ファイル
  find_file     = "<leader>ff",
  file_explorer = "<leader>fe",
  file_save     = "<leader>w", -- cmd +sでも保存できるようにする予定
  file_close    = "<leader>q",
  file_rename   = "<leader>fr",
  -- git
  git_status    = "<leader>gs",
  git_diff      = "<leader>gd",
}

keymap_set(semantic)
