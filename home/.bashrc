if [[ "$(uname)" == 'Darwin' ]]; then
  alias ls='ls -G -F'
else
  alias ls='ls --color=auto -F'
fi
alias la='ls -a'
alias ll='ls -lh'
alias lla='ls -lah'
alias l='ls'
alias cp='cp -i'
alias du='du -h'
alias ds='du -hs *'
alias grep='grep --color=auto'
alias od='od -c'
alias g='git'
alias py='python3 -q'
alias pip="pip3"
alias untar="tar xf"
alias tree='tree -CF'
alias htree='tree -hF'
alias pe='perl -pe'
alias xargs='xargs -I{} bash -c'
alias ca='highlight -O xterm256 -s rdark --force'
alias les="/usr/share/vim/**/less.sh"
alias t='tmux'
alias ta='tmux a'
alias crontab='crontab -i'
alias tac='tail -r'

if [[ -x "$(command -v rlwrap)" ]] ; then
  alias rl='rlwrap -pYellow -ic'
  alias sftp="rl sftp";
fi
search-word(){ grep -rI --exclude-dir={.git,"*vendor/bundle*"} "$@" . ; }
search(){ find . -follow -name "*$@*" 2> /dev/null | grep "$@" ; }
lns(){ lla | grep -- " -> " | awk '{printf "%-15s %s %s\n",$9,$10,$11}' ; }
mkdirs(){ mkdir -p "$@" ; cd "$@" ; }
ipy(){ ipython3 --quiet --autoindent --pprint --no-confirm-exit --no-term-title --quick --nosep --no-simple-prompt --no-banner --classic -c "from numpy import *;from numpy.linalg import *;from pprint import pprint as p;`[[ $DISPLAY ]] && echo 'import matplotlib.pyplot as plt'`" -i ; }
[[ -x "$(command -v vtop)" ]] && alias vtop="vtop --theme seti"
export LESS='-imMRSF'
export LANG=ja_JP.UTF-8

export-path(){ [[ -d $1 ]] && export PATH=$1:${PATH}; }

# homeshick
[[ -d ~/.homesick/repos ]] && [[ -d ~/.homesick/repos/homeshick ]] && alias homeshick="${HOME}/.homesick/repos/homeshick/bin/homeshick"

# if zsh exists, force bash -> zsh
[[ $0 = "-bash" &&  -x "$(command -v zsh)" ]] && zsh

