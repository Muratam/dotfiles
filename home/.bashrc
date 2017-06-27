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
alias tar.gz="tar xfvz"
alias tree='tree -CF'
alias htree='tree -hF'
alias pe='perl -pe'
if [[ -x "$(command -v rlwrap)" ]] ; then
  alias rl='rlwrap -pYellow -ic'
  alias sftp="rl sftp";
fi
search-word(){ grep -rI --exclude-dir={.git,"*vendor/bundle*"} "$@" . ; }
search(){ find . -follow -name "*$@*" 2> /dev/null | grep "$@" ; }
lns(){ lla | grep -- " -> " | awk '{printf "%-15s %s %s\n",$9,$10,$11}' ; }
ipy(){ ipython3 --quiet --autoindent --pprint --no-confirm-exit --no-term-title --quick --nosep --no-simple-prompt --no-banner --classic -c "from numpy import *;from numpy.linalg import *;from pprint import pprint as p;`[[ $DISPLAY ]] && echo 'import matplotlib.pyplot as plt'`" -i ; }

################################
### SET ENVIRONMENT VARIABLE ###
################################
# ${HOME} will be expanded inside double quotation
# export PS1="\[\e[32m\][\w]\n\[\e[36m\]\W \$ \[\e[0m\]"
export LESS='-i -M -R -S -W -z-4 -x4 -F'
export LANG=ja_JP.UTF-8

export-path(){ [[ -d $1 ]] && export PATH=${PATH}:$1; }
# rust cargo
export-path ~/.cargo/bin
# workspace-d
export-path ~/codes/dlang/workspace-d/bin
# node modules without sudo
export-path ~/node_modules/.bin
# pip modules without sudo
export-path ~/.local/bin

# homeshick
if [[ -d ~/.homesick/repos ]]; then
  export PYTHONPATH=${PYTHONPATH}:~/.homesick/repos/dotfiles/module/python3
  export PATH=${PATH}:~/.homesick/repos/dotfiles/bin
  if [[ -d ~/.homesick/repos/homeshick ]]; then
    alias homeshick="${HOME}/.homesick/repos/homeshick/bin/homeshick"
  fi
fi


#########################
### FOR EACH COMPUTER ###
#########################

if [[ "$(hostname)" == "ringo" ]]; then
  export PYTHONPATH=${PYTHONPATH}:~/python/pepper/naoqi
  export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:~/python/pepper/naoqi
  unset MAILCHECK
elif [[ "$(uname)" == 'Darwin' ]]; then
  export RUST_SRC_PATH=~/.multirust/toolchains/beta-x86_64-apple-darwin/lib/rustlib/src/rust/src
fi



# if zsh exists, force bash -> zsh
if [[ $0 = "-bash" && `which zsh` ]]; then
  zsh ;
  exit;
fi