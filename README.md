# README

## Mac買い替え時の設定

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/yuki-ohashi2020/dotfiles/main/install.sh)"
chsh -s /bin/zsh
```

.から始まるファイルはホームディレクトリに追加されない
設定ファイルは.config  
データソースは.local

chzmoi apply(init)で実行されるrun_xx系は使わない
makeで叩いてsetupさせる

マシン1台しかないのでchzmoi applyは使わない
