source ~/.bashrc
autoload -U compinit; compinit
zstyle ':completion:*' list-colors ''
#autoload predict-on
#predict-on
setopt auto_cd
setopt list_packed
#setopt correct
PROMPT="%F{2}[%~]
%F{cyan}%1~ %(!.#.$) %f"
RPROMPT='@%18>..>%m%>>'

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