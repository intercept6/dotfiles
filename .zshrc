#################################################
# Private Functions
#################################################
# install homebrew
if [[ ! commands[brew] ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
function install_brews_app() {
  # If Homebrew is'nt installed, It will install Homebrew
  if (( !$+commands[$1] )); then
    brew install $1
  fi
}

#################################################
# Global Functions
#################################################
# history
install_brews_app fzf
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# ghq
install_brews_app ghq
function ghq-fzf() {
  local selected_dir=$(ghq list | fzf --query="$LBUFFER")

  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi

  zle reset-prompt
}
zle -N ghq-fzf
bindkey "^]" ghq-fzf

#################################################
# History's config
#################################################
HISTFILE=~/.zsh_history                     # 履歴ファイルの設定
HISTSIZE=1000000                            # メモリに保存される履歴の件数。(保存数だけ履歴を検索できる)
SAVEHIST=1000000                            # ファイルに何件保存するか
setopt extended_history                     # 実行時間とかも保存する
setopt share_history                        # 別のターミナルでも履歴を参照できるようにする
setopt hist_ignore_all_dups                 # 過去に同じ履歴が存在する場合、古い履歴を削除し重複しない
setopt hist_ignore_space                    # コマンド先頭スペースの場合保存しない
setopt hist_verify                          # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_reduce_blanks                   # 余分なスペースを削除してヒストリに記録する
setopt hist_save_no_dups                    # historyコマンドは残さない
setopt hist_expire_dups_first               # 古い履歴を削除する必要がある場合、まず重複しているものから削除
setopt hist_expand                          # 補完時にヒストリを自動的に展開する
setopt inc_append_history                   # 履歴をインクリメンタルに追加

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


#################################################
# Zplug's config
#################################################
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "RobSis/zsh-completion-generator", if:"GENCOMPL_FPATH=$HOME/.zsh/complete"
zplug "Tarrasch/zsh-functional" # each map filter fold
zplug "willghatch/zsh-hooks"
zplug "unixorn/warhol.plugin.zsh" # ansi
zplug "mollifier/zload"
zplug "b4b4r07/enhancd", use:"init.sh"
zplug "tcnksm/docker-alias", use:zshrc, as:plugin

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#################################################
# Alias
#################################################

alias ls='ls -G'
alias ll='ls -G -l'
alias la='ls -G -la'
alias grep='grep --color=auto' 2>/dev/null
alias egrep='egrep --color=auto' 2>/dev/null
alias fgrep='fgrep --color=auto' 2>/dev/null
install_brews_app colordiff
alias diff="colordiff"
install_brews_app rmtrash
alias rm='rmtrash'

if [ -r /etc/GREP_COLORS ]; then
	grep -qi "^COLOR.*none" /etc/GREP_COLORS >/dev/null 2>/dev/null && return
fi

#################################################
# Bind keys
#################################################
# foward and back word
bindkey '[C' forward-word
bindkey '[D' backward-word

#################################################
# Tools
#################################################
# anyenv
# can't use install_brews_app, because anyenv isn't command
if [[ ! -d ~/.anyenv ]]; then
  brew install anyenv
fi
eval "$(anyenv init -)"

if [[ -d $(pyenv root) ]]; then
  export PIPENV_VENV_IN_PROJECT=1
fi

# direnv
install_brews_app direnv
eval "$(direnv hook zsh)"

# autoload -Uz compinit && compinit -u
# autoload -U +X bashcompinit && bashcompinit
# compinit
# zstyle ':completion:*:default' menu select=1
# setopt menu_complete
# --------------
# cdr関連の設定
# --------------
# setopt AUTO_PUSHD # cdしたら自動でディレクトリスタックする
# setopt pushd_ignore_dups # 同じディレクトリは追加しない
# DIRSTACKSIZE=100 # スタックサイズ
# # cdr, add-zsh-hook を有効にする
# autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
# add-zsh-hook chpwd chpwd_recent_dirs
