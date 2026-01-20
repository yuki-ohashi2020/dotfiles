--[[
  共通のNeovim設定
  必ずinit.luaの最初で読み込むこと

  含まれる設定:
    - テキスト選択(textobject)
    - テキスト移動(motions)
    - テキスト編集(operator)
    -
]]

--[[
-------------------------------------------------------------------------------
--                           テキスト選択                                    --
-------------------------------------------------------------------------------
--]]
vim.opt.clipboard = "unnamedplus" -- クリップボードをOSと同期(yankでクリップボードにコピーされる)
vim.opt.selection = "inclusive"   -- カーソル位置の文字も選択対象にする
vim.opt.showmode = false          -- モード表示を非表示にする(モード表示はプラグインで行う)


--[[
-------------------------------------------------------------------------------
--                           テキスト移動                                    --
-------------------------------------------------------------------------------
--]]
-- 検索
vim.opt.ignorecase = true           -- 検索時に大文字/小文字を区別しない
vim.opt.smartcase = true            -- 大文字を含む検索したときは区別する
vim.opt.hlsearch = true             -- 検索結果をハイライトする
vim.opt.incsearch = true            -- インクリメンタルサーチを有効化(リアルタイムの絞り込み検索)
vim.opt.startofline = true          -- 移動時に行頭に移動する
-- カーソル移動
vim.opt.whichwrap:append("<,>,[,]") -- 左右の行移動を行頭/行末で可能にする
vim.opt.scrolloff = 3               -- カーソル位置から上下の行数を確保
vim.opt.sidescrolloff = 5           -- カーソル位置から左右の列数を確保
vim.opt.cursorline = true           -- カーソル行をハイライト表示する


-- インデント・タブ
vim.opt.smartindent = true -- 改行時に自動でインデント

-- nativeへ移す

-- Leaderキーの設定
local HALF_SPACE = " "
vim.g.mapleader = HALF_SPACE

-- キーバインド
local NORMAL_MODE = "n"
local INSERT_MODE = "i"
local km = vim.keymap
-- ノーマルモードのキーバインド
km.set(NORMAL_MODE, "x", '"_x')                          -- ヤンクせずに文字を削除する
km.set(NORMAL_MODE, "<Esc><Esc>", "<cmd>nohlsearch<CR>") -- ハイライトを解除する
-- インサートモードのキーバインド
km.set(INSERT_MODE, "jj", "<Esc>")                       -- ノーマルモードに戻る

--[[

- [ ] コメントを共通にしたい
	- [ ] 複数行コメント

  ]]
return {
  find = "<leader>f",
  git  = "<leader>g",
}
