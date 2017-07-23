###################
### SET ALIASES ###
###################
if [[ "$(uname)" == 'Darwin' ]]; then
  alias ls='ls -G -F'
  alias hl-chrome='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --headless --disable-gpu'
  # --print-to-pdf,--dump-dom,--screenshot
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
################################
### SET ENVIRONMENT VARIABLE ###
################################
export LESS='-imMRSF'
export LANG=ja_JP.UTF-8
export EDITOR=vi

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

# include languages settings (for miner languages)
source ~/.bashrc_languages.sh
# if zsh exists, force bash -> zsh
if [[ $0 = "-bash" &&  -x "$(command -v zsh)" ]]; then zsh ; exit; fi