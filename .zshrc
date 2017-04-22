source ~/.bashrc
export LANG=ja_JP.UTF-8
autoload -U compinit; compinit
zstyle ':completion:*' list-colors ''
#autoload predict-on
#predict-on
setopt auto_cd
setopt auto_param_slash
setopt auto_menu
setopt complete_in_word
setopt mark_dirs
setopt list_packed
#setopt correct
PROMPT="%F{2}[%~ @%m]
%F{cyan}%1~ %(!.#.$) %f"

autoload -Uz zmv
alias mmv='noglob zmv -W'
alias tree='tree -CF'
alias htree='tree -hF'
alias rl='rlwrap -pYellow -ic'

# cd + tab -> directory history
setopt auto_pushd
setopt pushd_ignore_dups
# extended glob (pattern match)
setopt extended_glob
# when command in history, delete old history
setopt hist_ignore_all_dups
# start with space, not save in history
setopt hist_ignore_space
# completion files
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ctrl-w -> delete until '/' treat these words as normal chalacters
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# history
export HISTFILE=${HOME}/.zsh_hist
export HISTSIZE=2000
export SAVEHIST=10000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

# command color
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


#setopt prompt_subst
#function zle-line-init zle-keymap-select {
#PROMPT="
#%{${fg[yellow]}%}%h:%~%{${reset_color}%}
#%(?.%{$fg[green]%}.%{$fg[cyan]%})(%(!.#.)%(?!-__-) !;__;%) )${${KEYMAP/vicmd/|}/(main|viins)/<}%{${reset_color}%} "
#zle reset-prompt
#}
#zle -N zle-line-init
#zle -N zle-keymap-select
#SPROMPT="%{$fg[cyan]%}%{$suggest%}(-__-)?< %B%r%b %{$fg[cyan]%}でしょうか? [(y)es,(n)o,(a)bort,(e)dit]:${reset_color} "

#function command_not_found_handler() {
#    echo "$fg[cyan](;-__-)< $0 というコマンドは見当たりませんが${reset_color}"
#}

#REPORTTIME=3
