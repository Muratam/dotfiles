# if zsh exists, force bash -> zsh, without chsh
([[ $0 = "bash" ]] || [[ $0 = "-bash" ]] ) && [[ $SHLVL -le 2 ]] && [[ -x "$(command -v zsh)" ]] &&  exec zsh -l

###################
### SET ALIASES ###
###################
if [[ "$(uname)" == 'Darwin' ]]; then
  alias ls='ls -G -F'
else
  alias ls='ls --color=auto -F'
fi
# override aliases
alias cp='cp -i'
alias crontab='crontab -i'
alias du='du -h'
alias od='od -c'
alias su='su -l'
alias grep='grep --color=auto'
alias xargs='xargs -I{} --no-run-if-empty bash -c'

# aliases
alias la='ls -a'
alias ll='ls -lh'
alias lla='ls -lah'
alias l='ls'
alias g='git'
alias t='tmux'
alias ta='tmux a'
alias ds='du -hs *'
alias py='python3 -q'
alias pip="pip3"
alias untar="tar xf"
alias tree='tree -CF'
alias htree='tree -hF'
alias pe='perl -pe'
alias les="/usr/share/vim/**/less.sh"
alias tac='tail -r'
search-word(){ grep -rI --exclude-dir={.git,"*vendor/bundle*"} "$@" . ; }
search(){ find . -follow -name "*$@*" 2> /dev/null | grep "$@" ; }
lns(){ lla | grep -- " -> " | awk '{printf "%-15s %s %s\n",$9,$10,$11}' ; }
mkdirs(){ mkdir -p "$@" ; cd "$@" ; }

# benri commands
execable(){ [[ -x "$(command -v $1)" ]] || [[ "$(command -v $1)" != "" ]] ; }
execable highlight && alias ca='highlight --infer-lang --failsafe -O xterm256 -s rdark --force'
execable ipython3 && ipy(){ ipython3 --quiet --autoindent --pprint --no-confirm-exit --no-term-title --quick --nosep --no-simple-prompt --no-banner --classic -c "from numpy import *;from numpy.linalg import *;from pprint import pprint as p;`[[ $DISPLAY ]] && echo 'import matplotlib.pyplot as plt'`" -i ; }
execable vtop && alias vtop="vtop --theme seti"
execable thefuck && eval "$(thefuck --alias f)"
execable nyancat && alias n="nyancat"
if execable rlwrap ; then
  alias rl='rlwrap -pYellow -ic'
  alias sftp="rl sftp";
fi


################################
### SET ENVIRONMENT VARIABLE ###
################################
export LESS='-imMRSF'
export LANG=ja_JP.UTF-8
# export EDITOR=vi # c-a c-e が効かなくなる
unset MAILCHECK

export-path(){ [[ -d $1 ]] && export PATH=$1:${PATH}; }
# node modules without sudo
export-path ~/node_modules/.bin
# pip modules without sudo
export-path ~/.local/bin
# /usr/local/bin を優先
export-path /usr/local/bin
# local installs
export-path ~/.usr/bin

# homeshick
if [[ -d ~/.homesick/repos ]]; then
  export PYTHONPATH=${PYTHONPATH}:~/.homesick/repos/dotfiles/module/python3
  export-path ~/.homesick/repos/dotfiles/bin
  if [[ -d ~/.homesick/repos/homeshick ]]; then
    alias homeshick="${HOME}/.homesick/repos/homeshick/bin/homeshick"
  fi
fi