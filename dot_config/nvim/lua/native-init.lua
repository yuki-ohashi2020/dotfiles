--[[
Lazy.nvim setup
]]

-- 1. lazy.nvim 本体の自動インストール (Bootstrap)
-- ~/.local/share/nvim/lazy/lazy.nvim にインストールされる
local function bootstrap_lazy()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)
end


bootstrap_lazy()

-- 2. プラグインの設定
require("lazy").setup({
  -- 括弧の編集
  "tpope/vim-surround",
  -- ステータスラインの表示（INSERTやNORMALモードの表示など）
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end,
  },
  -- Zen Mode
  {
    "folke/zen-mode.nvim",
    lazy = false, -- 起動時に読み込む
    opts = {
      window = {
        width = 80,
        options = {
          number = true, -- 行番号を表示したままにする
          relativenumber = false,
        },
      },
    },
    config = function(_, opts)
      local zen = require("zen-mode")
      zen.setup(opts)
      -- Neovimが完全に起動した後にZenModeを実行する
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          zen.open()
        end,
      })
    end,
    -- キーバインドの設定（例： スペースキー + z で起動）
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
  },
})

-- vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, 'CursorIM', {
  bg = '#3c3836',
  fg = '#ebdbb2',
  blend = 0 -- 透明度を0に
})
-- 日本語入力中のカーソルの色
vim.api.nvim_set_hl(0, 'CursorIM', { bg = 'NONE', fg = 'NONE' })

-- これらも試してみてください
vim.api.nvim_set_hl(0, 'TermCursor', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'TermCursorNC', { bg = 'NONE' })

vim.opt.iminsert = 0
vim.opt.imsearch = 0
vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'CursorIM', { reverse = false, bg = 'NONE' })
  end
})
-- 行番号の最小幅を1にする（これで左の余白が最小限になります）
-- vim.opt.numberwidth = 1

-- ↓プラグインを追加する
-- カーソル位置・折り畳み状態の保存と復元
-- insetモードで入力行をハイライトさせる
-- 最近開いたファイルを見えるようにする
-- Telescope.nvim か ddu.vimを入れる
-- oil.nvim, nvim-tree.lua, neo-tree.nvim
-- vim-easy-align
-- LuaSnip
-- nvim-cmp, ddc.vim
-- NeoBundle 'tpope/vim-abolish'
-- shaunsingh/solarized.nvim や maxmx0/solarized.nvim
-- gitsigns.nvim
-- alpha-nvim, dashboard-nvim
-- monaqa/dial.nvim
-- folke/flash.nvim, phaazon/hop.nvim
-- lukas-reineke/indent-blankline.nvim
-- mini.align
vim.keymap.set('i', 'jj', '<Esc>')
local km = vim.keymap
-- ノーマルモードのキーバインド

local NORMAL_MODE = "n"
local INSERT_MODE = "i"
-- 共通のキーバインド
km.set(NORMAL_MODE, "x", '"_x') -- ヤンクせずに文字を削除する
-- km.set(NORMAL_MODE, "<Esc><Esc>", "<cmd>nohlsearch<CR>") -- ハイライトを解除する
-- インサートモードのキーバインド
km.set(INSERT_MODE, "jj", "<Esc>") -- ノーマルモードに戻る

-- Leaderキーをvs codeで使うかは検討が必要
-- if not vim.g.vscode then
-- Leaderキーをスペースに設定
vim.g.mapleader = " "

-- <Leader>w で保存、<Leader>q で終了
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")


vim.opt.showmode = false            -- モード表示を非表示にする(モード表示はプラグインで行う)
-- カーソル移動
vim.opt.whichwrap:append("<,>,[,]") -- 左右の行移動を行頭/行末で可能にする
vim.opt.scrolloff = 3               -- カーソル位置から上下の行数を確保
vim.opt.sidescrolloff = 5           -- カーソル位置から左右の列数を確保
vim.opt.cursorline = true           -- カーソル行をハイライト表示する

local opt = vim.opt

-- インデント関連
opt.expandtab = true          -- タブ入力をスペースに変換
opt.tabstop = 4               -- 画面上のタブ幅
opt.softtabstop = 0           -- Tabキー押下時の挙動（0はtabstopに従う）
opt.shiftwidth = 4            -- 自動インデントの幅

vim.opt.mouse = "a"           -- マウス操作を有効化
vim.opt.virtualedit = "block" -- Visual Modeの矩形選択で文字がない範囲も選択可能にする
vim.opt.list = true
-- vim.opt.listchars = "eol:↲,tab:» ,trail:·,nbsp:␣"
-- インデント方式
opt.autoindent = true -- 改行時に前の行のインデントを継続


-- 外観・表示関連
opt.title = true         -- ウィンドウタイトルを表示
opt.number = true        -- 行番号を表示
opt.cursorline = true    -- カーソル行を強調
opt.scrolloff = 999      -- 常にカーソルを画面中央に配置
opt.list = true          -- 不可視文字を表示
-- opt.listchars = { tab = ">-", extends = "<", trail = "-" } -- 不可視文字のスタイル
opt.display = "lastline" -- 長い行も極力表示
opt.cmdheight = 2        -- コマンドラインの高さ

-- インタラクション
opt.showmatch = true                    -- 対応する括弧を表示
opt.matchtime = 1                       -- 括弧表示のタイマー（0.1秒単位）
opt.completeopt = { "menu", "preview" } -- 補完メニューの挙動
opt.virtualedit = "block"               -- 矩形選択時のみ自由にカーソルを動かせる

-- ステータスライン（自作設定をLua形式で移植）
opt.statusline = "%<%f %m%r%h%w %{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'} %= %l,%c%V %P"

-- 【補足】カーソル形状の設定は、NeovimならこれだけでOK（多くのターミナルで有効）
opt.guicursor = "i:ver25" -- 挿入モードで垂直棒状にする


-- コマンドライン・履歴
opt.wildmode = { "full", "list" } -- 補完の挙動
-- opt.history = 100 -- 必要であれば

-- 検索関連
opt.ignorecase = true -- 検索時に大文字小文字を区別しない
opt.smartcase = true  -- 大文字が含まれる場合は区別する
opt.wrapscan = true   -- 最後まで検索したら先頭に戻る

-- クリップボード（NeovimならこれだけでOK）
-- OSのクリップボードと常に同期させる設定です
-- opt.clipboard:append({ "unnamedplus" })
-- バッファ・ファイル管理
opt.hidden = false   -- あえて nohidden にする場合（保存必須）
opt.swapfile = false -- スワップファイルを作らない
-- opt.filetype:plugin('on') -- filetype plugin indent on

local keymap = vim.keymap.set

-- バッファ・ファイル管理
opt.hidden = false   -- あえて nohidden にする場合（保存必須）
opt.swapfile = false -- スワップファイルを作らない
-- opt.filetype:plugin('on') -- filetype plugin indent on

-- 挿入モード
keymap('i', 'jj', '<Esc>', { desc = "Escの代わり" })
keymap('i', '<C-D>', '<Del>')

-- ノーマル/ビジュアルモード共通
keymap('', 'j', 'gj')
keymap('', 'k', 'gk')
keymap('', ';', ':')
keymap('', ':', ';')

-- ノーマルモード
keymap('n', 'Y', 'y$', { desc = "行末までヤンク" })
keymap('n', 'Q', '<Nop>')
keymap('n', '<Tab>', '<C-w>w')
keymap('n', '+', '<C-a>', { desc = "インクリメント" })
keymap('n', '-', '<C-x>', { desc = "デクリメント" })


-- 挿入モードでの記号入力補助
keymap('i', '<C-a>', '@')
keymap('i', '<C-d>', '$')
keymap('i', '<C-p><C-l>', '+')
keymap('i', '<C-m><C-i>', '-')
keymap('i', '<C-e><C-q>', '=')

-- 高度なヤンク・ペースト挙動
-- 貼り付け後に末尾へ移動
keymap('v', 'y', 'y`]')
keymap('n', 'p', 'p`]')
keymap('v', 'p', 'p`]')
-- 0番レジスタからのペースト
keymap('n', 'P', '"0p`]')
keymap('v', 'P', '"0p`]')

-- c* でカーソル下の単語を置換対象にする（exprマッピング）
keymap('n', 'c*', [[:%s ;\<<C-r><C-w>\>;]], { desc = "カーソル下の単語を全置換準備" })

-- コマンドラインモード
keymap('c', '<C-p>', '<Up>')
keymap('c', '<C-n>', '<Down>')

-- .vimrc.neobundleのプラグインの代替を探すこと

-- 折りたたみの基本設定
opt.foldmethod = "marker" -- {{{ }}} を折りたたみの目印にする
opt.foldcolumn = "3"      -- 左側に折りたたみ状態を表示する幅
opt.foldlevel = 0         -- ファイルを開いた時はすべて折りたたむ

-- 【重要】設定ファイルの末尾にこれを記述してください
-- -- vim: foldmethod=marker
