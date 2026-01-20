-- 共通設定
require("common-init")

-- VS CodeのNeovim拡張機能の設定
if vim.g.vscode then
  require("vscode-init")
  -- ネイティブの設定を読み込むと競合するのでreturnする
  return
end

-- ネイティブの設定
require("native-init")

-- Neovideの設定
if vim.g.neovide then
  require("neovide-init")
end
