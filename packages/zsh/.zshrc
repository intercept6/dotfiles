# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=30000
SAVEHIST=30000

# 直前のコマンドの重複を削除
setopt hist_ignore_dups
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# 同時に起動したzshの間でヒストリを共有
setopt share_history

# 補完機能を有効にする
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補を詰めて表示
setopt list_packed
# 補完候補一覧をカラー表示
zstyle ':completion:*' list-colors ''

zstyle ':completion:*' ignore-parents parent pwd ..   # ../ の後は今いるディレクトリを補間しない
zstyle ':completion:*:default' menu select=1          # 補間候補一覧上で移動できるように
zstyle ':completion:*:cd:*' ignore-parents parent pwd # 補間候補にカレントディレクトリは含めない

# starshipを適用
if [ -f /opt/homebrew/bin/starship ]; then
    eval "$(starship init zsh)"
fi

# alias
alias ls='ls -aF'
alias ll='ls -l'
