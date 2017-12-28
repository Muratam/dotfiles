# if zsh exists, force bash -> zsh, without chsh
# [[ $0 = "bash" ]] ||    :: destroys sftp
( [[ $0 = "-bash" ]] || [[ $0 = "su" ]] ) && [[ $SHLVL -le 2 ]] && [[ -x "$(command -v zsh)" ]] &&  exec zsh -l
# use xterm-256
[[ $TERM = "xterm" ]] && export TERM='xterm-256color'
execable(){ type $1 > /dev/null 2>&1 ;  }


###################
### SET ALIASES ###
###################
if [[ "$(uname)" == 'Darwin' ]]; then
  alias ls='ls -G -F'
  alias hl-chrome='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --headless --disable-gpu'
  # --print-to-pdf,--dump-dom,--screenshot
else
  alias ls='ls --color=auto -F'
  execable gnuls && alias ls='gnuls --color=auto -F'
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
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lAh'
alias l='ls'
alias g='git'
alias t='tmux'
alias ta='tmux a'
alias ds='du -hs * 2> /dev/null'
alias li='lsof -i'
alias py='python3 -q'
alias pip="pip3"
alias tree='tree -CF'
alias pe='perl -pe'
# execable rg && alias grep='rg'
search-word(){ grep -rI --exclude-dir={.git,"*vendor/bundle*"} "$@" . ; }
search(){ find . -follow -name "*$@*" 2> /dev/null | grep "$@" ; }
lns(){ lla | grep -- " -> " | awk '{printf "%-15s %s %s\n",$9,$10,$11}' ; }
mkdirs(){ mkdir -p "$@" ; cd "$@" ; }
awkp(){ astr='{ print ' ; for a in $@; do astr+="\$$a, " ; done ; astr+='"" }' ; awk $astr ; }

# benri commands
execable highlight && ca(){ highlight -O xterm256 -s rdark --force $@ ; } \
                   && les(){ ca $@ | less ; }
execable ipython3 && ipy(){ ipython3 --quiet --autoindent --pprint --no-confirm-exit --no-term-title --quick --nosep --no-simple-prompt --no-banner --classic -c "from numpy import *;from numpy.linalg import *;from pprint import pprint as p;`[[ $DISPLAY ]] && echo 'import matplotlib.pyplot as plt'`" -i ; }
execable irb && alias irb='irb --simple-prompt'
execable tldr && alias f='tldr $(fc -ln -1 | tail -n 1 | awkp 1)'
[[ "$(command -v tac)" == "" ]] && alias tac='tail -r'

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
export-path ~/.root/bin
export-path ~/.root/usr/bin/

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
