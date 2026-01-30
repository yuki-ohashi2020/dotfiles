############################################################################
# プロンプト
############################################################################
# ! p10k configure で作り直せる

CACHE_PL_10K_FILE=$LOCAL_CACHE_PATH/p10k-instant-prompt-${(%):-%n}.zsh
[[ -r $CACHE_PL_10K_FILE ]] && source $CACHE_PL_10K_FILE

# powerlevel10k プラグイン
source "$DATA_P10K_PATH/powerlevel10k.zsh-theme"
# powerlevel10k の設定
source "$CONFIG_PATH/zsh/.p10k.zsh"
