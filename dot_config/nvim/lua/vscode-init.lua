
-- VSCodeのコマンドをLeaderから呼び出す例
local keymap = vim.keymap.set

-- <Leader>ff でVSCodeのファイル検索(Quick Open)を開く
keymap('n', '<Leader>ff', "<cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")

-- <Leader>ee でサイドバー（エクスプローラー）にフォーカス
keymap('n', '<Leader>ee', "<cmd>call VSCodeNotify('workbench.view.explorer')<CR>")

-- <Leader>rr でシンボルのリネーム（VSCodeの機能を使う）
keymap('n', '<Leader>rr', "<cmd>call VSCodeNotify('editor.action.rename')<CR>")