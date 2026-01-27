require("common-init")      -- 共通設定
require("keymaps.semantic") -- キーマップの定義

-- IM切り替えが安定するか検証: 01/27
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    -- macOSの場合 (macism をインストール済みであることが前提)
    vim.fn.system("macism com.apple.keylayout.ABC")

    -- Windowsの場合 (im-select.exe をインストール済みであることが前提)
    -- vim.fn.system("im-select.exe 1033")
  end,
})

if vim.g.vscode then
  require("vscode-init") -- VS CodeのNeovim拡張機能の設定
  return                 -- VS Codeでネイティブの設定を読み込むと競合するのでreturnする
end

require("native-init") -- ネイティブ(Neovim)の設定
