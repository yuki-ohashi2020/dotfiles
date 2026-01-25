# README

## Mac買い替え時の設定

```bash
xcode-select --install
/bin/bash -c "$(curl -fsLS get.chezmoi.io)" -- init --apply yuki-ohashi2020/dotfiles

# todo
# xcode-select --install
# brew install chezmoi
# chezmoi -- init --apply yuki-ohashi2020/dotfiles
```

.から始まるファイルはホームディレクトリに追加されない
設定ファイルは.config  
データソースは.local
