## TERM

if grep '^uim-fep' /proc/$PPID/cmdline > /dev/null; then
	export TERM=xterm
fi

case $TERM in
 linux)
	 fbterm uim-fep --vesa-mode=323
 ;;
 xterm)
	precmd(){
	 print -Pn "\e]2;[%n@%m]\a"
	}
	
 ;;
esac


######################
##                  ##
##  File Operation  ##
##                  ##
######################

autoload -U compinit && compinit
setopt auto_cd
setopt auto_pushd
setopt correct
setopt magic_equal_subst
setopt nobeep
setopt prompt_subst
setopt list_packed
setopt print_eight_bit
setopt no_flow_control
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin



##############
##          ##
##  PROMPT  ##
##          ##
##############

autoload -U colors && colors
# root user is red another grenn
case $UID in
0)
	PROMPT='[%F{red}%n%f@%F{cyan}%m%f(%T)]%# '

 ;;
*)
	PROMPT='[%F{green}%n%f@%F{cyan}%m%f:%T]%# '
 ;;

esac

#public
	PROMPT2=" > "
	RPROMPT='[%F{green}%d%f]'
	SPROMPT="correct '%R' to '%r'
 No
 Yes
 Abort
 Edit
(please select n,y,a.e)>"





###############
##           ##
##  HISTORY  ##
##           ##
###############

HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt extended_history
setopt hist_ignore_dups #ignore duplication command history list
setopt share_history    #share command history data
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


#####################
##                 ##
##  ALIAS COMMAND  ##
##                 ##
#####################

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

#######################
##                   ##
##  zsh-completions  ##
##                   ##
#######################

fpath=(/usr/local/share/zsh-completions $fpath)

######################################
##                                  ##
##  source zsh-syntax-highlighting  ##
##                                  ##
######################################

[[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && . ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


