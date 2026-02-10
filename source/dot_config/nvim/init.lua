require("common-init")      -- 共通設定
require("keymaps.semantic") -- キーマップの定義
-- viminfoを無効化（空にする）
vim.opt.viminfo = ""

-- IM切り替えが安定するか検証: 02/01
-- ノーマルモードに戻る時に英数(ABC)に切り替え
vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
  pattern = "*",
  callback = function()
    vim.fn.system("/opt/homebrew/bin/im-select com.apple.keylayout.ABC")
  end,
})

if vim.g.vscode then
  require("vscode-init") -- VS CodeのNeovim拡張機能の設定
  return                 -- VS Codeでネイティブの設定を読み込むと競合するのでreturnする
end

require("native-init") -- ネイティブ(Neovim)の設定
