require("common-init")      -- 共通設定
require("keymaps.semantic") -- キーマップの定義


if vim.g.vscode then
  require("vscode-init") -- VS CodeのNeovim拡張機能の設定
  return                 -- VS Codeでネイティブの設定を読み込むと競合するのでreturnする
end

require("native-init") -- ネイティブ(Neovim)の設定

if vim.g.goneovim then
  require("goneovim-init") -- Goneovim(GUI)の設定
end
