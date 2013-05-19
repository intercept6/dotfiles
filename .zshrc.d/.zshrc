###
### TERM
###


## fbrerm status check & rum uim-fep ##

if grep '^fbterm' /proc/$PPID/cmdline > /dev/null; then
	export TERM=xterm
	uim-fep
fi

## TERM check ##
case $TERM in
 linux)
	 case $HOSTNAME in
		 "debian")
			 	 fbterm --vesa-mode=323
		 ;;
	 *)
		;;
	esac
 ;;
 xterm)
	precmd(){
	 print -Pn "\e]2;[%n@%m]\a"
	}
	
 ;;
esac

###
### PROMPT
###

autoload -U colors && colors

p_HostName="@%F{cyan}%m%f"
p_Date="(%T)"
p_UserPermissions="%# "
p_Pwd="[%F{green}%d%f]"
p_correct="correct '%R' to '%r'
 No
 Yes
 Abort
 Edit
(please select n,y,a.e)>"
p_CmdResult="%(?.%F{green}Command Succes%f.%F{red}Command Faild%f)
"

case $UID in
0)
	p_UserName="%F{red}%n%f"

 ;;
*)
	p_UserName="%F{green}%n%f"
 ;;

esac

	PROMPT=$p_CmdResult"["$p_UserName$p_HostName$p_Date"]"$p_UserPermissions	
	PROMPT2=" > "
	RPROMPT=$p_Pwd
	SPROMPT=$p_correct

###
### File Operation
###

## General ##

setopt auto_cd				#ディレクトリ名の入力のみで'cd'として認識
setopt auto_pushd			#cd -[TAB]でディレクリ履歴を表示
setopt correct				#コマンドスペルを修正
setopt magic_equal_subst		#=以降も補完する(--prefix=/usrなど)
setopt nobeep				#beep音を無効にする
setopt prompt_subst			#プロンプト定義内で変数置換やコマンド置換を扱う
setopt print_eight_bit
setopt no_flow_control

## Complement ##

autoload -U compinit && compinit	#補完機能を有効にする
setopt auto_menu
setopt list_packed
setopt list_types
bindkey '^[[Z' reverse-menu-complete
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

## Glob ##
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

###
###  HISTORY
###

## history file ##

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

## General ##

setopt extended_history		#
setopt hist_ignore_dups		#ignore duplication command history list
setopt share_history		#share command history data
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

## Command ##
function history-all { history -E 1 }

###
### ALIAS COMMAND
###

setopt complete_aliases
#alias ls="ls -G -w"
alias la="ls -a"
alias lf="ls -F"
alias ll="la -lh"
#alias du="du -h"
alias df="df -h"
#alias -s txt=lv
#alias -s md=lv
#alias -s markdown=lv
#alias -s xml=lv
alias vi="vim"
#alias bup="brew update"
#alias brug="brew upgrade"
#alias bs="brew -S"
#alias bi="brew info"

###
###  zsh-completions
###

fpath=(/usr/local/share/zsh-completions $fpath)


###
### source zsh-syntax-highlighting
###

[[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && . ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


